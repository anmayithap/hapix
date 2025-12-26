# =========================================================================
# == SHARED MODULE: Network Utilities (Data Synchronization)
# This module defines tools for robust data transfer and synchronization.
# It provides 'rsync', the definitive utility for incremental file
# mirroring, ensuring high-performance data movement across both
# Darwin and NixOS environments.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Network Logic Definition
  # -----------------------------------------------------------------------
  # We install synchronization tools at the system level to ensure they
  # are available for administrative scripts, automated backups, and
  # manual data migration tasks.
  network-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # ### rsync
      # A fast, versatile, remote (and local) file-copying tool.
      #
      # Why we include it at the system level:
      # - Incremental Backups: Efficiently syncs only changed parts of files.
      # - Modernity: macOS ships with an extremely outdated rsync (v2.x).
      #   Providing the latest version from Nixpkgs (v3.x+) enables
      #   support for advanced features like --info, --progress, and
      #   better performance/security.
      # - Automation: Essential for CI/CD pipelines and deployment scripts.
      rsync
    ];
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the rsync-equipped network suite into both the Darwin
  # and NixOS registries. This ensures that data synchronization
  # syntax remains identical across your entire infrastructure.
  flake.modules = {
    # macOS Network Registry
    darwin.network-programs = network-programs;

    # NixOS Network Registry
    nixos.network-programs = network-programs;
  };
}
