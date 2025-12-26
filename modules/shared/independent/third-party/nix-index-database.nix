# =========================================================================
# == SHARED MODULE: nix-index-database (System Integration)
# This module integrates the Nix index database logic into the global
# system environment. It specifically enables the 'comma' utility,
# providing a "run-on-the-fly" capability that allows users to execute
# any Nix package by prefixing the command with a comma.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Index Database Logic Definition
  # -----------------------------------------------------------------------
  # This module relies on the 'nix-index-database' flake being imported
  # into the system's base profile.
  nix-index-database = {lib, ...}: {
    programs.nix-index-database = {
      # ### Comma (,) Integration
      # 'comma' is a powerful wrapper that catches "command not found"
      # events and searches the pre-built nix-index database.
      #
      # Example: Typing `, cowsay "Hello"` will find the cowsay package,
      # fetch it into the store if missing, and run it immediately.
      #
      # Enabling this at the system level ensures the shell wrapper
      # is correctly initialized for all system users, complementing
      # the user-specific settings in Home Manager.
      comma.enable = lib.mkDefault true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the nix-index system settings into both the Darwin and
  # NixOS registries. This guarantees that the ubiquitous ',' command
  # is available across the entire managed infrastructure.
  flake.modules = {
    # macOS Index Registry
    darwin.nix-index-database = nix-index-database;

    # NixOS Index Registry
    nixos.nix-index-database = nix-index-database;
  };
}
