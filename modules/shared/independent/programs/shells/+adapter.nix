# =========================================================================
# == SHARED MODULE: Shell Adapters & Environment Integration
# This module provides the "glue" logic required to integrate shells into
# the system environment. It ensures that enabled shells are registered
# as valid login shells and that their support files (like completions)
# are correctly symlinked into the system PATH.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Environment Logic Definition
  # -----------------------------------------------------------------------
  # This adapter logic reacts to the state of other modules. It doesn't
  # enable the shells itself, but configures the system to support them
  # once they are enabled.
  environment = {
    lib,
    pkgs,
    config,
    ...
  }: {
    environment = {
      # ### Shell Registration
      # We add Zsh to the list of valid system shells only if it has
      # been enabled elsewhere in the configuration.
      #
      # Registering a shell in 'environment.shells' is required for:
      # - Using 'chsh' to change the default user shell.
      # - Allowing SSH and other services to recognize the shell as a
      #   valid login environment.
      shells = lib.optionals config.programs.zsh.enable [
        pkgs.zsh
      ];

      # ### Path Linking (Completions & Functions)
      # In a Nix-managed system, shell support files (completions, site-
      # functions, etc.) are scattered across different store paths.
      #
      # By linking "/share/zsh", we ensure that Zsh can find completion
      # scripts for all installed system packages (like git, docker,
      # or nix utilities) in a centralized location.
      pathsToLink = lib.optionals config.programs.zsh.enable [
        "/share/zsh"
      ];
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the environment adapters into both the Darwin and NixOS
  # registries. This ensures that shell integration "just works"
  # regardless of the host operating system.
  flake.modules = {
    # macOS Environment Registry
    darwin.environment = environment;

    # NixOS Environment Registry
    nixos.environment = environment;
  };
}
