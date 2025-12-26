# =========================================================================
# == SHARED MODULE: Flake Library Namespace (Schema)
# This module establishes a centralized, structured namespace for custom
# utility functions and constants. By defining 'flake.lib' as an option,
# it allows helpers defined in our library to be accessed via the 'config'
# argument in any module, promoting code reuse and modularity.
# =========================================================================
{lib, ...}: {
  options = {
    # -----------------------------------------------------------------------
    # ## flake.lib Option Definition
    # -----------------------------------------------------------------------
    # We define a common namespace to expose utility functions and values.
    # While Nix Flakes have a top-level 'lib' output, exposing it through
    # the module system (via config.flake.lib) allows for more dynamic
    # integration with NixOS/Darwin options.

    flake.lib = lib.mkOption {
      # ### Type Definition
      # We use 'attrsOf unspecified' to allow this namespace to store
      # any Nix value—be it a simple string, a complex attribute set,
      # or a high-level function (lambda).
      type = lib.types.attrsOf lib.types.unspecified;

      # ### Default State
      # Initialized as an empty set.
      default = {};

      # A safe, literal representation for generated documentation.
      defaultText = lib.literalExpression "''{}''";

      # ### Documentation
      # This metadata is consumed by nix-darwin/NixOS manual generators.
      description = ''
        Defines a common namespace, `flake.lib`, for exposing custom utility
        functions and values throughout the configuration.

        This provides a centralized location to store and access helper functions,
        making them easily reusable across different modules without needing
        to pass 'inputs' or 'self' manually into every function call.
      '';

      # ### Practical Usage Example
      # Demonstrates the "Define once, use everywhere" pattern.
      example = lib.literalExpression ''
        # Defining a helper in a library module:
        flake.lib = {
          mkGreeting = name: "Hello, ''${name}!";
          constants.projectRoot = "/srv/my-project";
        };

        # Consuming the helper in a service module:
        # { config, ... }: {
        #   environment.motd = config.flake.lib.mkGreeting "NixOS User";
        # }
      '';
    };
  };
}
