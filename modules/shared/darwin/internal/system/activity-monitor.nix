# =========================================================================
# == SHARED DARWIN MODULE: System (Activity Monitor)
# This module manages the default preferences for the macOS Activity
# Monitor. It ensures that the application provides a hierarchical
# and comprehensive view of all system processes upon launch.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## System Defaults Definition
  # -----------------------------------------------------------------------
  # We use the `system.defaults` namespace to declaratively manage
  # macOS .plist preferences.
  system = {lib, ...}: {
    system.defaults.ActivityMonitor = {
      # ### Initial Window State
      # Automatically open the main window when the application is launched.
      # This prevents the app from starting only in the Dock or Menu Bar
      # without a visible interface.
      OpenMainWindow = lib.mkDefault true;

      # ### Process View Category
      # Defines which processes are shown by default.
      # Value `101` corresponds to "All Processes, Hierarchically".
      #
      # This view is superior for debugging as it groups child processes
      # under their parents (e.g., specific tabs under a browser process),
      # making it easier to trace resource consumption.
      ShowCategory = lib.mkDefault 101;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the Activity Monitor defaults into the global Darwin
  # registry. This ensures that every host inheriting the base system
  # profile has a unified diagnostic tool configuration.
  flake.modules.darwin = {inherit system;};
}
