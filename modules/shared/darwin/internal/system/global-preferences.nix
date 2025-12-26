# =========================================================================
# == SHARED DARWIN MODULE: Global Preferences (Input & Interaction)
# This module manages low-level system settings that apply across the
# entire macOS environment. It primarily targets input hardware
# sensitivity to ensure consistent cursor behavior across different
# workstations and pointing devices.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Global Preferences Logic Definition
  # -----------------------------------------------------------------------
  # The ".GlobalPreferences" namespace targets the NSGlobalDomain, which
  # affects all applications and system-wide behaviors.
  system = {lib, ...}: {
    system.defaults.".GlobalPreferences" = {
      # ### Mouse Tracking Scaling
      # This setting controls the speed and acceleration of the mouse
      # cursor.
      #
      # A value of 5.0 is significantly higher than the macOS default,
      # providing high-sensitivity tracking. This is ideal for
      # high-resolution displays or multi-monitor setups where rapid
      # cursor movement across large screen areas is required.
      #
      # Note: We use `lib.mkDefault` to allow for device-specific
      # overrides (e.g., lower sensitivity on a travel laptop).
      "com.apple.mouse.scaling" = lib.mkDefault 5.;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the global input preferences into the Darwin registry.
  # This serves as a foundational layer for user interaction consistency.
  flake.modules.darwin = {inherit system;};
}
