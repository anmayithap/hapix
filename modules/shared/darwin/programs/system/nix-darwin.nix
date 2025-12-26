# =========================================================================
# == SHARED DARWIN MODULE: nix-darwin System Utilities
# This module integrates the essential nix-darwin command-line tools into
# the system PATH. These utilities are required for managing the lifecycle
# of the Darwin configuration, allowing for system rebuilds, version
# tracking, and option inspection.
# =========================================================================
{inputs, ...}: let
  # -----------------------------------------------------------------------
  # ## System Programs Logic Definition
  # -----------------------------------------------------------------------
  system-programs = {pkgs, ...}: {
    # ### Environment Packages
    # We explicitly pull the management binaries from the nix-darwin input
    # itself. This ensures that the versions of the tools (like rebuild)
    # perfectly match the version of the modules used to build the system.
    environment.systemPackages = with inputs.nix-darwin.packages.${pkgs.system}; [
      # `darwin-rebuild`: The primary CLI tool used to apply changes and
      # switch between system generations.
      darwin-rebuild

      # `darwin-option`: A powerful diagnostic tool used to inspect the
      # current values, defaults, and declarations of any nix-darwin option.
      darwin-option

      # `darwin-version`: Displays the current version of the nix-darwin
      # system and its associated commit hash.
      darwin-version

      # `darwin-uninstaller`: Provides a safe mechanism to remove
      # nix-darwin from the host if a manual cleanup is ever required.
      darwin-uninstaller
    ];
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the nix-darwin utility suite into the Darwin registry.
  # This ensures that every managed host has the native tools required
  # to manage its own state.
  flake.modules.darwin = {
    inherit system-programs;
  };
}
