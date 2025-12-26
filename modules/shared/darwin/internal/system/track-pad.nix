# =========================================================================
# == SHARED DARWIN MODULE: System UI (Trackpad & Haptics)
# This module declaratively manages trackpad behavior and haptic feedback.
# It prioritizes ergonomic comfort by reducing required physical pressure
# for clicks and enabling intuitive gestures like tap-to-click and
# right-click zones.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Trackpad Logic Definition
  # -----------------------------------------------------------------------
  # These settings control the "Trackpad" and "Force Click" behaviors found
  # in macOS System Settings.
  system = {lib, ...}: {
    system.defaults.trackpad = {
      # ### Clicking & Haptics
      # Enable "Tap to Click". This allows for a lighter touch interaction,
      # reducing finger fatigue over long sessions.
      Clicking = lib.mkDefault true;

      # Enable standard dragging behavior.
      Dragging = lib.mkDefault true;

      # ### Force Touch Sensitivity
      # Defines the physical pressure required to trigger a click.
      # Value '1' corresponds to the "Light" setting, requiring the
      # least amount of force.
      FirstClickThreshold = lib.mkDefault 1;

      # Value '1' for the second stage (Force Click), making deep-press
      # actions easier to trigger.
      SecondClickThreshold = lib.mkDefault 1;

      # ### Feedback Strength
      # Sets the intensity of the haptic "click" sensation (Actuation).
      # '1' provides a standard, crisp tactile response.
      ActuationStrength = lib.mkDefault 1;

      # ### Secondary Interaction
      # Enable the two-finger tap (or corner click) as a Right Click.
      TrackpadRightClick = lib.mkDefault true;

      # ### Gesture Management
      # Disable the "Three Finger Drag" in favor of standard dragging
      # or accessibility-based dragging.
      TrackpadThreeFingerDrag = lib.mkDefault false;

      # Set the three-finger tap gesture behavior.
      # '0' typically disables the default "Look up & data detectors"
      # to prevent accidental triggers during navigation.
      TrackpadThreeFingerTapGesture = lib.mkDefault 0;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the trackpad defaults into the Darwin registry. This
  # ensures that all managed Apple hardware (MacBooks and Magic
  # Trackpads) provides a unified, highly sensitive interactive feel.
  flake.modules.darwin = {
    inherit system;
  };
}
