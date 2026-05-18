#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> darwin-preferences -> defaults] darwin defaults preset
#: ----------------------------------------------------------------------------
#: See: https://macos-defaults.com/
#:
#: Note: `defaults` means configuring Darwin settings with the `defaults` CLI utility, and
#: not the default configuration. Here is a preset that is extremely convenient for me.
{
  hapix.darwin-preferences.defaults = {
    darwin = {lib, ...}: let
      D = lib.mkDefault;
    in {
      system.defaults = {
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/ActivityMonitor.nix
        ActivityMonitor = {
          #: Change with processes to show.
          #: * 100: All Processes
          #: * 101: All Processes, Hierarchally
          #: * 102: My Processes
          #: * 103: System Processes
          #: * 104: Other User Processes
          #: * 105: Active Processes
          #: * 106: Inactive Processes
          #: * 107: Windowed Processes
          ShowCategory = D 101;
          #: Change the icon in the dock when running.
          #: * 0: Application Icon
          #: * 2: Network Usage
          #: * 3: Disk Activity
          #: * 5: CPU Usage
          #: * 6: CPU History
          IconType = D 5;
          SortColumn = D "CPUUsage";
          #: Sort direction of the `SortColumn`.
          #: * 0: Descending
          #: * 1: Ascending
          SortDirection = D 0;
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/GlobalPreferences.nix
        ".GlobalPreferences" = {
          #: Configure mouse tracking speed.
          "com.apple.mouse.scaling" = D 5.;
          #: Configure system-wide alert sound.
          "com.apple.sound.beep.sound" = lib.mkDefault "/System/Library/Sounds/Frog.aiff";
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/LaunchServices.nix
        LaunchServices = {
          #: Enable quarantine for downloaded applications.
          LSQuarantine = D true;
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/NSGlobalDomain.nix
        NSGlobalDomain = {
          #: Whether to always show hidden files.
          AppleShowAllFiles = D true;
          AppleEnableMouseSwipeNavigateWithScrolls = D true;
          AppleEnableSwipeNavigateWithScrolls = D true;
          AppleFontSmoothing = D 0; # ## Disable font smoothing
          AppleInterfaceStyle = D "Dark";
          #: Icon and widget style.
          #: * RegularDark
          #: * RegularAutomatic
          #: * ClearLight
          #: * ClearDark
          #: * ClearAutomatic
          #: * TintedLight
          #: * TintedDark
          #: * TintedAutomatic
          AppleIconAppearanceTheme = D "ClearAutomatic";
          AppleInterfaceStyleSwitchesAutomatically = D false;
          #: Keyboard control behavior.
          #: * 0: Disabled
          #: * 1: Enabled on Sonoma or later
          #: * 2: Enabled on older macOS versions
          AppleKeyboardUIMode = D 0;
          ApplePressAndHoldEnabled = D false;
          AppleShowAllExtensions = D true;
          #: When to show the scrollbars.
          #: * WhenScrolling
          #: * Automatic
          #: * Always
          AppleShowScrollBars = D "Automatic";
          AppleScrollerPagingBehavior = D false;
          AppleSpacesSwitchOnActivate = D true;
          NSAutomaticCapitalizationEnabled = D true;
          NSAutomaticInlinePredictionEnabled = D true;
          NSAutomaticDashSubstitutionEnabled = D true;
          NSAutomaticPeriodSubstitutionEnabled = D true;
          NSAutomaticQuoteSubstitutionEnabled = D true;
          NSAutomaticSpellingCorrectionEnabled = D true;
          NSAutomaticWindowAnimationsEnabled = D true;
          NSDocumentSaveNewDocumentsToCloud = D false;
          #: Window tabbing when opening a new document.
          #: * manual
          #: * always
          #: * fullscreen
          AppleWindowTabbingMode = D "manual";
          NSNavPanelExpandedStateForSaveMode = D false;
          NSNavPanelExpandedStateForSaveMode2 = D false;
          #: Size of the finder sidebar icons.
          #: * 1: Small
          #: * 2: Medium
          #: * 3: Large
          NSTableViewDefaultSizeMode = D 3;
          NSTextShowsControlCharacters = D false;
          NSUseAnimatedFocusRing = D true;
          NSScrollAnimationEnabled = D true;
          NSWindowResizeTime = D 0.02;
          NSWindowShouldDragOnGesture = D true;
          PMPrintingExpandedStateForPrint = D false;
          PMPrintingExpandedStateForPrint2 = D false;
          "com.apple.mouse.tapBehavior" = D 1; # ## Enables tap to click.
          "com.apple.sound.beep.volume" = D 0.6065307;
          "com.apple.sound.beep.feedback" = D 1;
          "com.apple.trackpad.enableSecondaryClick" = D true;
          "com.apple.trackpad.trackpadCornerClickBehavior" = D 1; # ## Enables right click.
          "com.apple.trackpad.scaling" = D 0.875;
          "com.apple.trackpad.forceClick" = D true;
          "com.apple.springing.enabled" = D true;
          "com.apple.springing.delay" = D 0.5;
          "com.apple.swipescrolldirection" = D true;
          _HIHideMenuBar = D false;
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/SoftwareUpdate.nix
        SoftwareUpdate = {
          AutomaticallyInstallMacOSUpdates = D false;
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/WindowManager.nix
        WindowManager = {
          #: Enable Stage Manager
          GloballyEnabled = D true;
          EnableStandardClickToShowDesktop = D true;
          AutoHide = D false;
          AppWindowGroupingBehavior = D false;
          StandardHideDesktopIcons = D true;
          HideDesktop = D true;
          EnableTilingByEdgeDrag = D true;
          EnableTopTilingByEdgeDrag = D true;
          EnableTilingOptionAccelerator = D true;
          EnableTiledWindowMargins = D true;
          StandardHideWidgets = D false;
          StageManagerHideWidgets = D false;
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/clock.nix
        menuExtraClock = {
          FlashDateSeparators = D false;
          IsAnalog = D false;
          ShowDayOfMonth = D true;
          ShowDayOfWeek = D true;
          #: Show the full date.
          #: * 0: When space allows
          #: * 1: Always
          #: * 2: Never
          ShowDate = D 0;
          ShowSeconds = D true;
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/controlcenter.nix
        controlcenter = {
          BatteryShowPercentage = D true;
          Sound = D false;
          Bluetooth = D false;
          AirDrop = D false;
          Display = D false;
          FocusModes = D false;
          NowPlaying = D false;
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/dock.nix
        dock = {
          appswitcher-all-displays = D true;
          autohide = D true;
          autohide-delay = D 0.24;
          autohide-time-modifier = D 1.0;
          dashboard-in-overlay = D false;
          enable-spring-load-actions-on-all-items = D true;
          expose-animation-duration = D 1.0;
          expose-group-apps = D true;
          launchanim = D true;
          #: Minimize/maximize window effect.
          #: * genie
          #: * suck
          #: * scale
          mineffect = D "scale";
          minimize-to-application = D true;
          mouse-over-hilite-stack = D true;
          mru-spaces = D false;
          #: Position of the dock on screen.
          #: * bottom
          #: * left
          #: * right
          orientation = D "bottom";
          scroll-to-open = D true;
          showAppExposeGestureEnabled = D true;
          showDesktopGestureEnabled = D true;
          showLaunchpadGestureEnabled = D true;
          showMissionControlGestureEnabled = D true;
          show-process-indicators = D true;
          showhidden = D true;
          show-recents = D false;
          slow-motion-allowed = D false;
          static-only = D false;
          tilesize = D 68;
          magnification = D false;
          largesize = D 16;
          #: Hot corner action for top left corner.
          #: * `1`: Disabled
          #: * `2`: Mission Control
          #: * `3`: Application Windows
          #: * `4`: Desktop
          #: * `5`: Start Screen Saver
          #: * `6`: Disable Screen Saver
          #: * `7`: Dashboard
          #: * `10`: Put Display to Sleep
          #: * `11`: Launchpad
          #: * `12`: Notification Center
          #: * `13`: Lock Screen
          #: * `14`: Quick Note
          wvous-tl-corner = D 13;
          #: Hot corner action for bottom left corner.
          wvous-bl-corner = D 2;
          #: Hot corner action for top right corner.
          wvous-tr-corner = D 4;
          #: Hot corner action for bottom right corner.
          wvous-br-corner = D 1;
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/finder.nix
        finder = {
          AppleShowAllFiles = D true;
          ShowStatusBar = D true;
          ShowPathbar = D true;
          #: Default search scope.
          #: * `SCcf`: Current Folder
          FXDefaultSearchScope = D "SCcf";
          FXRemoveOldTrashItems = D true;
          #: Default finder view.
          #: * `clmv`: Column View
          #: * `icnv`: Icon View
          #: * `Nlsv`: List View
          #: * `Flwv`: Gallery View
          FXPreferredViewStyle = D "clmv";
          AppleShowAllExtensions = D true;
          CreateDesktop = D false;
          QuitMenuItem = D false;
          ShowExternalHardDrivesOnDesktop = D false;
          ShowHardDrivesOnDesktop = D false;
          ShowMountedServersOnDesktop = D false;
          ShowRemovableMediaOnDesktop = D false;
          _FXEnableColumnAutoSizing = D true;
          _FXShowPosixPathInTitle = D true;
          _FXSortFoldersFirst = D true;
          _FXSortFoldersFirstOnDesktop = D true;
          FXEnableExtensionChangeWarning = D true;
          #: Default folder shown in Finder windows.
          #: * `Home`
          #: * `Desktop`
          #: * `Documents`
          #: * `Recents`
          #: * `iCloud Drive`
          #: * `Other`
          #: * `OS volume`
          #: * `Computer`
          NewWindowTarget = D "Home";
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/iCal.nix
        iCal = {
          CalendarSidebarShown = D true;
          "TimeZone support enabled" = D true;
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/loginwindow.nix
        loginwindow = {
          SHOWFULLNAME = D false;
          GuestEnabled = D false;
          ShutDownDisabled = D false;
          SleepDisabled = D false;
          RestartDisabled = D false;
          ShutDownDisabledWhileLoggedIn = D false;
          PowerOffDisabledWhileLoggedIn = D false;
          RestartDisabledWhileLoggedIn = D false;
          DisableConsoleAccess = D false;
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/screencapture.nix
        screencapture = {
          type = D "jpg";
          disable-shadow = D false;
          include-date = D true;
          save-selections = D true;
          show-thumbnail = D true;
          #: Target to which screencapture should save screenshot to.
          #: * `clipboard`
          #: * `file`
          #: * `preview`
          #: * `mail`
          #: * `messages`
          target = D "clipboard";
        };
        #: See: https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/trackpad.nix
        trackpad = {
          Clicking = D true;
          Dragging = D true;
          TrackpadRightClick = D true;
          TrackpadThreeFingerDrag = D false;
          #: * 0: Enable Silent Clicking
          #: * 1: Disable Silent Clicking
          ActuationStrength = D 1;
          #: * 0: Light clicking
          #: * 1: Medium clicking
          #: * 2: Firm clicking
          FirstClickThreshold = D 1;
          #: * 0: Light clicking
          #: * 1: Medium clicking
          #: * 2: Firm clicking
          SecondClickThreshold = D 1;
          #: Whether to enable three-finger tap gesture.
          #: * 0: Disable
          #: * 2: Trigger Look up & data detectors.
          TrackpadThreeFingerTapGesture = D 0;
          ActuateDetents = D true;
          DragLock = D false;
          ForceSuppressed = D false;
          #: Whether to enable secondary click.
          #: * 0: Disable
          #: * 1: Set to bottom-left corner
          #: * 2: Set to bottom-right corner
          TrackpadCornerSecondaryClick = D 0;
          #: * 0: Disable four finger vertical swipe gestures
          #: * 2: Enable (down for Mission Control, up for App Expose)
          TrackpadFourFingerHorizSwipeGesture = D 2;
          TrackpadMomentumScroll = D true;
          TrackpadPinch = D true;
          TrackpadRotate = D true;
          #: Whether to enable three-finger horizontal swipe gesture.
          #: * 0: Disable
          #: * 1: Swipe between pages
          #: * 2: Swipe between full-screen applications
          TrackpadThreeFingerHorizSwipeGesture = D 2;
          #: Whether to enable three-finger vertical swipe gesture (down for Mission Control, up for App Exposé).
          #: * 0: Disable
          #: * 2: Enable
          TrackpadThreeFingerVertSwipeGesture = D 2;
          TrackpadTwoFingerDoubleTapGesture = D true;
          #: Whether to enable two-finger swipe-from-right-edge gesture.
          #: * 0: Disable
          #: * 3: Open Notification Center
          TrackpadTwoFingerFromRightEdgeSwipeGesture = D 3;
        };
      };
    };
  };
}
