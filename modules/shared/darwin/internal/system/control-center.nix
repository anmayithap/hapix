# =========================================================================
# == SHARED DARWIN MODULE: System (Control Center & Menu Bar)
# This module configures the visibility of various system controls in the
# macOS Menu Bar. It is designed to reduce visual clutter by hiding
# non-essential status icons while enabling helpful telemetry like
# precise battery percentages.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Control Center Logic Definition
  # -----------------------------------------------------------------------
  # These settings correspond to the "Control Center" pane in macOS
  # System Settings. Most boolean values here determine whether a
  # specific icon is "Pinned" to the Menu Bar.
  system = {lib, ...}: {
    system.defaults.controlcenter = {
      # ### Connectivity & Sharing
      # Setting these to 'false' hides their dedicated icons from the
      # Menu Bar, keeping them accessible only within the Control Center
      # "bubble" to save space.
      AirDrop = lib.mkDefault false;
      Bluetooth = lib.mkDefault false;

      # ### Energy Management
      # Enables the digital percentage readout next to the battery icon.
      # This provides more immediate and precise feedback than the
      # standard battery glyph.
      BatteryShowPercentage = lib.mkDefault true;

      # ### System Media & Focus
      # Hides redundant sliders and toggles from the top-right Menu Bar.
      Display = lib.mkDefault false;
      FocusModes = lib.mkDefault false;
      NowPlaying = lib.mkDefault false;
      Sound = lib.mkDefault false;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the Control Center defaults into the Darwin registry.
  # This modular approach allows for a "clean-by-default" UI across
  # all Mac workstations.
  flake.modules.darwin = {inherit system;};
}
