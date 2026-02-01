# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: NS Global Domain
# ----------------------------------------------------------------------------
# See: `defaults read -g`
{
  flake.modules.darwin.ns-global-domain = {lib, ...}: {
    system.defaults.NSGlobalDomain = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleIconAppearanceTheme
      AppleIconAppearanceTheme = lib.mkDefault "ClearAutomatic";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleInterfaceStyle
      AppleInterfaceStyle = lib.mkDefault "Dark";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically
      AppleInterfaceStyleSwitchesAutomatically = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleKeyboardUIMode
      # 0 - Disabled
      AppleKeyboardUIMode = lib.mkDefault 0;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleMeasurementUnits
      AppleMeasurementUnits = lib.mkDefault "Centimeters";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleMetricUnits
      # 1 - True
      AppleMetricUnits = lib.mkDefault 1;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled
      ApplePressAndHoldEnabled = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleScrollerPagingBehavior
      AppleScrollerPagingBehavior = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleShowAllExtensions
      AppleShowAllExtensions = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleShowAllFiles
      AppleShowAllFiles = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleShowScrollBars
      AppleShowScrollBars = lib.mkDefault "Automatic";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleSpacesSwitchOnActivate
      AppleSpacesSwitchOnActivate = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleTemperatureUnit
      AppleTemperatureUnit = lib.mkDefault "Celsius";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.InitialKeyRepeat
      InitialKeyRepeat = lib.mkDefault 15;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.KeyRepeat
      KeyRepeat = lib.mkDefault 2;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled
      NSAutomaticCapitalizationEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled
      NSAutomaticDashSubstitutionEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSAutomaticInlinePredictionEnabled
      NSAutomaticInlinePredictionEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled
      NSAutomaticPeriodSubstitutionEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled
      NSAutomaticQuoteSubstitutionEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled
      NSAutomaticSpellingCorrectionEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled
      NSAutomaticWindowAnimationsEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud
      NSDocumentSaveNewDocumentsToCloud = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode
      NSNavPanelExpandedStateForSaveMode = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2
      NSNavPanelExpandedStateForSaveMode2 = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSScrollAnimationEnabled
      NSScrollAnimationEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode
      # 3 - Large
      NSTableViewDefaultSizeMode = lib.mkDefault 3;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSTextShowsControlCharacters
      NSTextShowsControlCharacters = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSUseAnimatedFocusRing
      NSUseAnimatedFocusRing = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSWindowResizeTime
      NSWindowResizeTime = lib.mkDefault 0.02;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture
      NSWindowShouldDragOnGesture = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint
      PMPrintingExpandedStateForPrint = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2
      PMPrintingExpandedStateForPrint2 = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._HIHideMenuBar
      _HIHideMenuBar = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._com.apple.keyboard.fnState_
      "com.apple.keyboard.fnState" = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._com.apple.sound.beep.feedback_
      # 1 - True
      "com.apple.sound.beep.feedback" = lib.mkDefault 1;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._com.apple.sound.beep.volume_
      # 0.6065307 - 50%
      "com.apple.sound.beep.volume" = lib.mkDefault 0.6065307;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._com.apple.springing.delay_
      "com.apple.springing.delay" = lib.mkDefault 0.5;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._com.apple.springing.enabled_
      "com.apple.springing.enabled" = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._com.apple.swipescrolldirection_
      "com.apple.swipescrolldirection" = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._com.apple.trackpad.enableSecondaryClick_
      "com.apple.trackpad.enableSecondaryClick" = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._com.apple.trackpad.forceClick_
      "com.apple.trackpad.forceClick" = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._com.apple.trackpad.scaling_
      "com.apple.trackpad.scaling" = lib.mkDefault 0.875;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain._com.apple.trackpad.trackpadCornerClickBehavior_
      # 1 - right click
      "com.apple.trackpad.trackpadCornerClickBehavior" = lib.mkDefault 1;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleEnableMouseSwipeNavigateWithScrolls
      AppleEnableMouseSwipeNavigateWithScrolls = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleEnableSwipeNavigateWithScrolls
      AppleEnableSwipeNavigateWithScrolls = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleICUForce24HourTime
      AppleICUForce24HourTime = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.AppleWindowTabbingMode
      AppleWindowTabbingMode = lib.mkDefault "manual";
    };
  };
}
