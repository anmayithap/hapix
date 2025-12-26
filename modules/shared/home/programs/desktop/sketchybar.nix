# =========================================================================
# == SHARED HOME-MANAGER MODULE: Sketchybar Status Bar
# This module configures Sketchybar, a powerful and highly customizable
# status bar for macOS. It manages the installation of the binary and
# ensures the background service is correctly orchestrated within the
# user's Home Manager session.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Sketchybar Logic Definition
  # -----------------------------------------------------------------------
  # We define the status bar settings as a standard Home Manager module.
  # Sketchybar is typically used in conjunction with window managers like
  # yabai or aerospace to provide system telemetry and workspace status.
  programs = {lib, ...}: {
    programs.sketchybar = {
      # ### Activation
      # Enable the Sketchybar status bar.
      # Using `lib.mkDefault` allows specific machines (e.g., a server
      # or a headless Mac) to disable the UI component if it's
      # not required.
      enable = lib.mkDefault true;

      # Note: Actual configuration (bar height, colors, items, and scripts)
      # is typically added here or imported from a separate styling file.
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the Sketchybar module into the Home Manager registry.
  # This makes it available for consumption by your user profiles,
  # ensuring a consistent "top bar" experience across all Darwin-based
  # environments.
  flake.modules.homeManager = {
    inherit programs;
  };
}
