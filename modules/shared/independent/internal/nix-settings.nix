# =========================================================================
# == SHARED MODULE: Nix Daemon Configuration
# This module optimizes the Nix package manager's internal behavior.
# It enables modern experimental features, configures automated
# maintenance (Garbage Collection & Store Optimization), and integrates
# community-maintained binary caches to minimize local compilation times.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Nix Logic Definition
  # -----------------------------------------------------------------------
  nix-settings = {lib}: {
    nix = {
      # ### Store Optimization
      # Automatically detect and hardlink identical files in the Nix store.
      # This significantly reduces disk space consumption by ensuring that
      # duplicate dependencies across different packages occupy only a
      # single physical block on the drive.
      optimise.automatic = lib.mkDefault true;

      # -----------------------------------------------------------------------
      # ## Daemon Settings
      # -----------------------------------------------------------------------
      settings = {
        # ### Binary Caches (Substituters)
        # We integrate the 'nix-community' cache. This provides pre-built
        # binaries for many community-maintained flakes (like home-manager
        # or neovim-nightly), sparing your CPU from long compilation tasks.
        substituters = lib.mkBefore [
          "https://nix-community.cachix.org"
        ];

        # Associated public key to verify the integrity of downloaded
        # binaries from the nix-community cache.
        trusted-public-keys = lib.mkBefore [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        # ### Experimental Features
        # Enable the 'nix-command' CLI and 'flakes' support.
        # These are essential for evaluating this configuration and
        # leveraging modern, reproducible Nix development workflows.
        experimental-features = lib.mkBefore [
          "nix-command"
          "flakes"
        ];

        # ### Access Control
        # Restrict the ability to modify the Nix daemon to the root user.
        # This is a baseline security posture that ensures only
        # administrative processes (like your system switch) can
        # alter the Nix store state.
        allowed-users = lib.mkBefore [
          "root"
        ];
      };

      # -----------------------------------------------------------------------
      # ## Garbage Collection (GC)
      # -----------------------------------------------------------------------
      # Automatically remove old, unreferenced package generations
      # to prevent the Nix store from consuming all available disk space.
      gc = {
        automatic = lib.mkDefault true;

        # We schedule the cleanup for 08:30 AM.
        # This "morning routine" ensures that the system starts the day
        # with a clean store, removing artifacts from the previous
        # day's development sessions.
        interval = lib.mkBefore [
          {
            Hour = 8;
            Minute = 30;
          }
        ];
      };
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers these daemon optimizations into both Darwin and NixOS
  # registries. This ensures that the Nix engine performs with
  # consistent efficiency regardless of the host operating system.
  flake.modules = {
    # macOS Nix Registry
    darwin.nix-settings = nix-settings;

    # NixOS Nix Registry
    nixos.nix-settings = nix-settings;
  };
}
