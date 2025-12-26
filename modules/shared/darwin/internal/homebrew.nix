# =========================================================================
# == SHARED DARWIN MODULE: Homebrew Integration
# This module provides a declarative interface for the Homebrew package
# manager on macOS. It manages the lifecycle of taps, global behaviors,
# and integrates with 'nix-homebrew' to ensure third-party repositories
# are handled consistently with the rest of the Nix system.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Homebrew Logic Definition
  # -----------------------------------------------------------------------
  homebrew = {
    lib,
    config,
    ...
  }: let
    inherit (config) nix-homebrew;
  in {
    homebrew = {
      # ### Activation
      # Enable Homebrew management via nix-darwin.
      enable = lib.mkDefault true;

      # ### Declarative Taps
      # This logic bridges the gap between 'nix-homebrew' and the standard
      # darwin homebrew options. If 'nix-homebrew' is enabled, we
      # automatically register all managed taps into the main homebrew
      # tap list to ensure they are visible to the system.
      taps = lib.optionalAttrs nix-homebrew.enable builtins.attrNames nix-homebrew.taps;

      # -----------------------------------------------------------------------
      # ## Global Behavior
      # -----------------------------------------------------------------------
      global = {
        # ### Auto-Update Policy
        # We disable auto-updates by default. In a declarative system,
        # we want to control when Homebrew updates to ensure stability
        # and prevent "hidden" side effects during system activation.
        autoUpdate = lib.mkDefault false;
      };
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the Homebrew orchestration module into the Darwin registry.
  # This component is essential for macOS systems that require software
  # not yet packaged in Nixpkgs or proprietary GUI applications.
  flake.modules.darwin = {inherit homebrew;};
}
