# =========================================================================
# == SHARED MODULE: Network Utilities & API Tooling
# This module defines the global networking toolkit. It provides modern,
# human-friendly alternatives to legacy utilities, ensuring that
# developers and sysadmins have powerful tools for API interaction
# and network diagnostics across both Darwin and NixOS.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Network Logic Definition
  # -----------------------------------------------------------------------
  # These programs are installed globally to facilitate quick network
  # testing and web service debugging directly from the system shell.
  network-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # ### HTTPie (http / https commands)
      # A modern, user-friendly command-line HTTP client.
      # Unlike 'curl', HTTPie provides:
      # - Automatic JSON support and formatting.
      # - Syntax highlighting for terminal output.
      # - Intuitive, Python-like syntax for headers and data.
      #
      # This is an essential tool for modern web development and
      # inspecting REST/GraphQL APIs.
      httpie
    ];
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the network suite into both the Darwin and NixOS registries.
  # This ensures that the 'http' command is available consistently
  # across the entire managed infrastructure.
  flake.modules = {
    # macOS Network Registry
    darwin.network-programs = network-programs;

    # NixOS Network Registry
    nixos.network-programs = network-programs;
  };
}
