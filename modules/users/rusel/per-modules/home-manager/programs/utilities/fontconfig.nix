# =========================================================================
# == USER PROFILE: rusel (Typography Utilities - fontconfig)
# This module integrates the fontconfig command-line utilities into the
# user environment. It provides the necessary tools to inspect, debug,
# and manage the system's font library directly from the terminal.
# =========================================================================
{
  flake.modules.homeManager.rusel = {pkgs, ...}: {
    # -----------------------------------------------------------------------
    # ## User Packages
    # -----------------------------------------------------------------------
    home.packages = with pkgs; [
      # ### fontconfig (CLI Tools)
      # Provides a suite of utilities for font discovery and management:
      # - 'fc-list': Lists all fonts available to the system/user.
      # - 'fc-match': Troubleshoots font substitution and matching logic.
      # - 'fc-cache': Manually triggers a refresh of the font information cache.
      #
      # These tools are essential for verifying that our JetBrains Mono
      # and Nerd Font installations are correctly recognized by the OS.
      fontconfig
    ];
  };
}
