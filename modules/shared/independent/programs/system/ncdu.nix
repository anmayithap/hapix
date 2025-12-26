# =========================================================================
# == SHARED MODULE: System Utilities (Disk Analysis)
# This module defines the global storage observability toolkit. It
# provides 'ncdu', an interactive disk usage analyzer, ensuring that
# users can quickly identify and manage large files across both
# Darwin and NixOS environments.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## System Programs Logic Definition
  # -----------------------------------------------------------------------
  # We install 'ncdu' at the system level to facilitate rapid disk
  # maintenance and troubleshooting directly from the system shell.
  system-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # ### ncdu (NCurses Disk Usage)
      # A disk usage analyzer with an ncurses interface.
      #
      # Key benefits over standard 'du':
      # - Interactivity: Allows navigating through the directory tree
      #   to find the exact source of storage pressure.
      # - Performance: Written in C, making it extremely fast even on
      #   massive filesystems like the Nix store.
      # - Deletion: Provides a safe, built-in mechanism to delete
      #   unwanted files directly from the interface.
      ncdu
    ];
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the disk analysis capabilities into both the Darwin and
  # NixOS registries. This ensures that 'ncdu' is a standard diagnostic
  # tool across the entire infrastructure.
  flake.modules = {
    # macOS System Registry
    darwin.system-programs = system-programs;

    # NixOS System Registry
    nixos.system-programs = system-programs;
  };
}
