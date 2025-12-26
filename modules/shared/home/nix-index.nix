# =========================================================================
# == SHARED HOME-MANAGER MODULE: nix-index-database
# This module integrates the nix-index database into the user environment.
# It provides fast file-to-package lookups and enables the 'comma' utility,
# allowing for the seamless execution of uninstalled binaries through
# an automatically updated global index.
# =========================================================================
{inputs, ...}: let
  # -----------------------------------------------------------------------
  # ## Index Database Logic Definition
  # -----------------------------------------------------------------------
  nix-index-database-config = {lib, ...}: {
    # We import the Home Manager module from the external nix-index-database
    # input. This provides the weekly-updated database instead of
    # requiring the user to manually (and slowly) index nixpkgs locally.
    imports = [
      inputs.nix-index-database.homeModules.nix-index
    ];

    # ### nix-index
    # The core tool for searching files within the Nix store.
    # When enabled, it allows you to find which package provides a
    # missing command or header file.
    programs.nix-index.enable = lib.mkDefault true;

    # ### Comma (,) Integration
    # 'comma' is a wrapper around nix-index and nix-shell (or nix run).
    #
    # When enabled, you can run any program by prefixing it with a comma:
    # Example: `, cowsay "Hello"`
    # Comma will find the package in the database and run it instantly
    # without you needing to add it to your configuration.
    programs.nix-index-database.comma.enable = lib.mkDefault true;
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the nix-index configuration into the Home Manager registry.
  # This makes advanced package discovery available to all user
  # environments across Darwin and NixOS.
  flake.modules.homeManager.nix-index = nix-index-database-config;
}
