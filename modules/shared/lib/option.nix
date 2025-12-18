{lib, ...}: {
  options = {
    flake.lib = lib.mkOption {
      # The type of the option: an attribute set where values can be of any type.
      type = lib.types.attrsOf lib.types.unspecified;

      # The default value: an empty attribute set.
      default = {};

      # A user-friendly text representation of the default value for documentation.
      defaultText = lib.literalExpression "''{}''";

      # The primary description of the option. This appears in generated documentation.
      description = ''
        Defines a common namespace, `flake.lib`, for exposing custom utility
        functions and values throughout a NixOS configuration.

        This provides a centralized location to store and access helper functions,
        making them easily reusable across different modules.
      '';

      # A practical example of how to use the option.
      example = lib.literalExpression ''
        # In your configuration.nix or a custom module:
        flake.lib = {
          mkGreeting = name: "Hello, ''${name}!";
          constants.projectRoot = "/srv/my-project";
        };

        # Elsewhere in your configuration:
        # { config, ... }: {
        #   environment.motd = config.flake.lib.mkGreeting "NixOS User";
        #   services.my-service.path = config.flake.lib.constants.projectRoot;
        # }
      '';
    };
  };
}
