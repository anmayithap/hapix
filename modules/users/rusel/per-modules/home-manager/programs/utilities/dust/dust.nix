# =========================================================================
# == USER PROFILE: rusel (Disk Analysis Utility - dust)
# This module installs 'dust', a modern version of 'du' written in Rust.
# It provides an intuitive, tree-based view of disk usage, making it
# significantly easier to identify large directories and files at a glance.
# =========================================================================
{
  flake.modules.homeManager.rusel = {pkgs, ...}: {
    # -----------------------------------------------------------------------
    # ## User Packages
    # -----------------------------------------------------------------------
    home.packages = with pkgs; [
      # ### dust (du + rust)
      # A high-performance disk usage analyzer that features:
      # - Instant visualization of directory hierarchies.
      # - Automatic sorting by size.
      # - Percentage-based bar graphs for rapid identification of "hot spots".
      dust
    ];
  };
}
