# =========================================================================
# == SHARED MODULE: Language Runtimes & Development Suites
# This module defines the global programming environments available across
# all hosts. It installs core compilers, interpreters, and runtimes,
# ensuring a consistent development baseline whether working on macOS
# or NixOS.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Language Logic Definition
  # -----------------------------------------------------------------------
  # We use 'environment.systemPackages' to make these runtimes available
  # globally in the system PATH.
  language-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # ### Go (Golang)
      # The Go programming language compiler and tooling.
      #
      # Installing Go at the system level is beneficial for:
      # - Compiling and installing tools via 'go install'.
      # - Running administrative scripts written in Go.
      # - Providing a stable fallback version for quick prototyping
      #   outside of dedicated 'nix develop' environments.
      go
    ];
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the language suite into both the Darwin and NixOS registries.
  # This guarantees that the 'go' binary and its associated toolchain
  # are present on every machine managed by this flake.
  flake.modules = {
    # macOS Language Registry
    darwin.language-programs = language-programs;

    # NixOS Language Registry
    nixos.language-programs = language-programs;
  };
}
