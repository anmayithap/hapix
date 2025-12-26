# =========================================================================
# == SHARED MODULE: Network Utilities (File Retrieval)
# This module defines the global file-downloading toolkit. It ensures that
# 'wget' is available system-wide, providing a reliable and non-interactive
# mechanism for retrieving content from the web across both Darwin
# and NixOS.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Network Logic Definition
  # -----------------------------------------------------------------------
  # We install 'wget' at the system level to facilitate robust file
  # fetching and background downloading tasks.
  network-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # ### GNU Wget
      # A free utility for non-interactive download of files from the Web.
      #
      # Key benefits:
      # - Robustness: Designed for reliability over slow or unstable
      #   network connections; it can automatically resume aborted downloads.
      # - Recursive Download: Capable of mirroring entire websites by
      #   following links and recreating directory structures locally.
      # - Background Operation: Can continue downloading even after a
      #   user has logged out, making it ideal for large data transfers.
      wget
    ];
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the file retrieval capabilities into both the Darwin and
  # NixOS registries. This ensures that the 'wget' command is present
  # and behaves consistently on every machine in the infrastructure.
  flake.modules = {
    # macOS Network Registry
    darwin.network-programs = network-programs;

    # NixOS Network Registry
    nixos.network-programs = network-programs;
  };
}
