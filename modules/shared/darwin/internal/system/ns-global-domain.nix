_: let
  system = {lib, ...}: {
    system.defaults.NSGlobalDomain = {
      AppleEnableMouseSwipeNavigateWithScrolls = lib.mkDefault true;
      AppleEnableSwipeNavigateWithScrolls = lib.mkDefault true;
      AppleICUForce24HourTime = lib.mkDefault true;
      AppleInterfaceStyle = lib.mkDefault "Dark";
      AppleMetricUnits = lib.mkDefault 1;
      ApplePressAndHoldEnabled = lib.mkDefault false;
      AppleShowAllExtensions = lib.mkDefault true;
      AppleShowAllFiles = lib.mkDefault true;
      AppleTemperatureUnit = lib.mkDefault "Celsius";
      AppleWindowTabbingMode = lib.mkDefault "manual";
      AppleKeyboardUIMode = lib.mkDefault 2;
      InitialKeyRepeat = lib.mkDefault 15;
      NSAutomaticCapitalizationEnabled = lib.mkDefault true;
      NSAutomaticPeriodSubstitutionEnabled = lib.mkDefault true;
      KeyRepeat = lib.mkDefault 2;
      "com.apple.keyboard.fnState" = lib.mkDefault false;
      "com.apple.trackpad.forceClick" = lib.mkDefault true;
      "com.apple.trackpad.scaling" = lib.mkDefault 0.875;
      "com.apple.springing.enabled" = lib.mkDefault true;
      "com.apple.springing.delay" = lib.mkDefault 0.5;
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
