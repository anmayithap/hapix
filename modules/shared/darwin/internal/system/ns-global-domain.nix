# =========================================================================
# == SHARED DARWIN MODULE: NSGlobalDomain (Global System Environment)
# This module configures the most fundamental behaviors of macOS. It
# defines the "feel" of the system, including high-speed keyboard repeat
# rates, dark mode preferences, metric units, and professional typing
# behaviors that bypass standard consumer-level restrictions.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Global System Logic Definition
  # -----------------------------------------------------------------------
  # Settings in NSGlobalDomain affect all applications and the core
  # Darwin environment.
  system = {lib, ...}: {
    system.defaults.NSGlobalDomain = {
      # ### Interface Aesthetics
      # Force the system-wide use of Dark Mode.
      AppleInterfaceStyle = lib.mkDefault "Dark";

      # ### Keyboard Ergonomics (The Developer's Speed)
      # These settings provide a significantly faster typing experience.

      # Disable the "Press and Hold" for accents. This is critical for
      # developers as it enables standard key-repeating for all keys—
      # essential for rapid navigation in Vim or other text editors.
      ApplePressAndHoldEnabled = lib.mkDefault false;

      # Set the delay before a key starts repeating (15 = 225ms).
      InitialKeyRepeat = lib.mkDefault 15;

      # Set the speed of the repeat itself (2 = 30ms). Combined, these
      # make the keyboard feel incredibly responsive.
      KeyRepeat = lib.mkDefault 2;

      # Use standard F1, F2, etc. keys as standard function keys.
      # Set to 'false' to use them as media keys by default.
      "com.apple.keyboard.fnState" = lib.mkDefault false;

      # ### Full Keyboard Access
      # Mode 2 enables full keyboard control of the UI, allowing the 'Tab'
      # key to navigate through all buttons and controls in dialog boxes.
      AppleKeyboardUIMode = lib.mkDefault 2;

      # ### Trackpad & Mouse Interaction
      # Enable swiping between pages (e.g., in Safari) using the scroll
      # gesture on a mouse or trackpad.
      AppleEnableMouseSwipeNavigateWithScrolls = lib.mkDefault true;
      AppleEnableSwipeNavigateWithScrolls = lib.mkDefault true;

      # Enable Force Click and haptic feedback on supported trackpads.
      "com.apple.trackpad.forceClick" = lib.mkDefault true;

      # Fine-tune the trackpad cursor speed.
      "com.apple.trackpad.scaling" = lib.mkDefault 0.875;

      # ### Spring-Loading (Drag & Drop)
      # Enable "springing"—where folders pop open when you hover over
      # them with a dragged item—and set a short 0.5s delay.
      "com.apple.springing.enabled" = lib.mkDefault true;
      "com.apple.springing.delay" = lib.mkDefault 0.5;

      # ### Localization & Units
      # Standardize on Metric and Celsius for a consistent scientific/
      # technical environment.
      AppleMetricUnits = lib.mkDefault 1;
      AppleTemperatureUnit = lib.mkDefault "Celsius";
      AppleICUForce24HourTime = lib.mkDefault true;

      # ### File System Transparency (Global)
      # Redundant with Finder but enforced at the domain level to ensure
      # all system dialogs show extensions and hidden files.
      AppleShowAllExtensions = lib.mkDefault true;
      AppleShowAllFiles = lib.mkDefault true;

      # ### Window Behavior
      # Disable automatic tab grouping in windows, preferring manual
      # control over how windows are tiled or tabbed.
      AppleWindowTabbingMode = lib.mkDefault "manual";

      # ### Intelligent Typing Assists
      # Keep standard assists enabled for general writing comfort.
      NSAutomaticCapitalizationEnabled = lib.mkDefault true;
      NSAutomaticPeriodSubstitutionEnabled = lib.mkDefault true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the global domain defaults into the Darwin registry.
  # This is the "bedrock" module that gives your entire configuration
  # its unique character and professional feel.
  flake.modules.darwin = {inherit system;};
}
