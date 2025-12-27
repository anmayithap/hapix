# =========================================================================
# == USER PROFILE: rusel (Disk Usage Utility - duf)
# This module installs 'duf', a modern and user-friendly alternative
# to the standard 'df' command. It provides a colorized, tabulated
# view of disk usage and free space across all mounted filesystems.
# =========================================================================
{
  flake.modules.homeManager.rusel = {pkgs, ...}: {
    # -----------------------------------------------------------------------
    # ## User Packages
    # -----------------------------------------------------------------------
    home.packages = with pkgs; [
      # ### duf (Disk Usage/Free Utility)
      # A TUI-based tool that provides:
      # - Human-readable output with color-coded bar graphs.
      # - Automatic grouping and filtering of filesystems.
      # - Sorting capabilities and JSON output support.
      duf
    ];
  };
}
