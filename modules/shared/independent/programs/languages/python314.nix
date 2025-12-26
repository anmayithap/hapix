# =========================================================================
# == SHARED MODULE: Language Runtimes (Python Suite)
# This module defines the global Python environment. It installs the
# specific Python 3.14 interpreter, providing a robust foundation for
# system scripting, automation, and modern software development on
# both Darwin and NixOS.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Language Logic Definition
  # -----------------------------------------------------------------------
  # We provide Python at the system level to ensure that essential
  # scripts and administrative tools have access to a consistent
  # and modern interpreter.
  language-programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # ### Python 3.14
      # The latest stable or cutting-edge iteration of the Python
      # programming language.
      #
      # System-level Python is essential for:
      # - Executing complex shell-replacing automation scripts.
      # - Providing a baseline interpreter for global CLI tools.
      # - Serving as a foundation for user-level virtual environments.
      python314
    ];
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the Python-equipped language suite into both the Darwin
  # and NixOS registries. This ensures that 'python3' points to the
  # same high-performance version across all managed devices.
  flake.modules = {
    # macOS Language Registry
    darwin.language-programs = language-programs;

    # NixOS Language Registry
    nixos.language-programs = language-programs;
  };
}
