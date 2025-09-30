{
  lib,
  profile,
  ...
}: let
  inherit (profile) homeDirectory;
in {
  time.timeZone = lib.mkDefault "Europe/Moscow";

  security.pam.services.sudo_local = {
    reattach = lib.mkDefault true;
    touchIdAuth = lib.mkDefault true;
  };

  system = {
    defaults = {
      dock = {
        autohide = lib.mkDefault true;
        show-recents = lib.mkDefault false;
        orientation = lib.mkDefault "bottom";
        mineffect = lib.mkDefault "scale";
        expose-group-apps = lib.mkDefault true;

        wvous-tl-corner = lib.mkDefault 2;
        wvous-bl-corner = lib.mkDefault 13;

        persistent-apps = lib.mkDefault [
          {
            app = "/System/Applications/System Settings.app";
          }
        ];
        persistent-others = lib.mkDefault [
          "${homeDirectory}/dev"
          "${homeDirectory}/Downloads"
        ];
      };

      screencapture = {
        location = lib.mkDefault "${homeDirectory}/Pictures/screenshots";
      };

      finder = {
        AppleShowAllExtensions = lib.mkDefault true;
        AppleShowAllFiles = lib.mkDefault true;
        CreateDesktop = lib.mkDefault false;
        FXPreferredViewStyle = lib.mkDefault "clmv";
        _FXSortFoldersFirst = lib.mkDefault true;
        FXDefaultSearchScope = lib.mkDefault "SCev";
        FXRemoveOldTrashItems = lib.mkDefault true;
        ShowExternalHardDrivesOnDesktop = lib.mkDefault false;
        _FXShowPosixPathInTitle = lib.mkDefault true;
        ShowStatusBar = lib.mkDefault true;
        ShowPathbar = lib.mkDefault true;
      };

      loginwindow = {
        GuestEnabled = lib.mkDefault false;
      };

      menuExtraClock = {
        Show24Hour = lib.mkDefault true;
        ShowDate = lib.mkDefault 0;
        ShowAMPM = lib.mkDefault null;
        ShowSeconds = lib.mkDefault true;
      };

      trackpad = {
        Clicking = lib.mkDefault true;
        Dragging = lib.mkDefault true;
        FirstClickThreshold = lib.mkDefault 1;
        TrackpadRightClick = lib.mkDefault true;
        TrackpadThreeFingerTapGesture = lib.mkDefault 0;
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = lib.mkDefault "Dark";
        AppleShowAllExtensions = lib.mkDefault true;
        AppleShowAllFiles = lib.mkDefault true;
        InitialKeyRepeat = lib.mkDefault 15;
        KeyRepeat = lib.mkDefault 2;
        ApplePressAndHoldEnabled = lib.mkDefault false;
      };

      CustomUserPreferences = {
        "com.apple.desktopservices" = lib.mkDefault {
          DSDontWriteNetworkStores = lib.mkDefault true;
          DSDontWriteUSBStores = lib.mkDefault true;
        };
      };
    };
  };
}
