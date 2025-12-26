# =========================================================================
# == SHARED DARWIN MODULE: System (Dock & Hot Corners)
# This module declaratively manages the macOS Dock and Hot Corners. It
# prioritizes a distraction-free workspace by hiding the Dock when not in
# use and mapping screen corners to critical system actions like Mission
# Control and Lock Screen.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## System Defaults Definition
  # -----------------------------------------------------------------------
  system = {lib, ...}: {
    system.defaults.dock = {
      # ### Dock Appearance & Layout
      # We enable autohide to maximize usable screen space. The Dock only
      # appears when the cursor touches the bottom edge.
      autohide = lib.mkDefault true;
      orientation = lib.mkDefault "bottom";
      tilesize = lib.mkDefault 68; # Icons are slightly larger for better legibility

      # ### Window Management
      # Groups windows by application in Mission Control (Exposé), making
      # it easier to navigate when multiple windows of the same app are open.
      expose-group-apps = lib.mkDefault true;

      # Use the "Scale" effect for minimizing windows; it is generally
      # snappier and less visually intrusive than the "Genie" effect.
      mineffect = lib.mkDefault "scale";

      # ### App Management
      # We maintain a minimalist Dock. By default, only System Settings is
      # pinned, encouraging the use of launchers (Spotlight/Raycast) for
      # other applications.
      persistent-apps = lib.mkDefault [
        {
          app = "/System/Applications/System Settings.app";
        }
      ];

      # Disable the "Recents" section to keep the Dock state predictable
      # and prevent visual clutter from temporary applications.
      show-recents = lib.mkDefault false;

      # -----------------------------------------------------------------------
      # ## Hot Corners (wvous)
      # -----------------------------------------------------------------------
      # Maps physical screen corners to specific macOS functions.
      # Values: 2 (Mission Control), 4 (Desktop), 13 (Lock Screen).
      # Top Left: Mission Control (Overview of all windows)
      wvous-tl-corner = lib.mkDefault 2;

      # Top Right: Desktop (Hide all windows)
      wvous-tr-corner = lib.mkDefault 4;

      # Bottom Left & Right: Lock Screen
      # Mapping both bottom corners to Lock Screen provides a quick "panic
      # gesture" to secure the machine when walking away.
      wvous-bl-corner = lib.mkDefault 13;
      wvous-br-corner = lib.mkDefault 13;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the Dock and Hot Corner defaults into the Darwin registry.
  # This ensures a consistent interactive "feel" across all managed
  # Apple hardware.
  flake.modules.darwin = {inherit system;};
}
