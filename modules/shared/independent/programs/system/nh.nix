# =========================================================================
# == SHARED MODULE: System Utilities (Nix Helper)
# This module integrates 'nh' (Nix Helper), a modern and high-performance
# wrapper for NixOS and Darwin management. It streamlines system
# rebuilds, garbage collection, and generation tracking with a focus on
# speed, better logging, and user-friendly CLI interaction.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## System Programs Logic Definition
  # -----------------------------------------------------------------------
  # We install 'nh' at the system level to serve as the primary entry point
  # for system maintenance tasks, complementing our custom 'nixh' wrapper
  # defined in the DevShell.
  system-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # ### nh (Nix Helper)
      # A powerful alternative to 'nixos-rebuild' and 'darwin-rebuild'.
      #
      # Key advantages:
      # - Visual Diffs: Automatically shows what changed between
      #   generations (when used with 'nvd').
      # - Better GC: Provides a much cleaner interface for cleaning
      #   old generations and the Nix store.
      # - Ease of Use: Uses a simple 'os switch' syntax that works
      #   identically on both Linux and macOS.
      # - Performance: Written in Rust for near-instant execution.
      nh
    ];
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the 'nh' utility into both the Darwin and NixOS registries.
  # This ensures that the modern management workflow is consistent
  # across the entire flake-managed infrastructure.
  flake.modules = {
    # macOS System Registry
    darwin.system-programs = system-programs;

    # NixOS System Registry
    nixos.system-programs = system-programs;
  };
}
