# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Dock
# ----------------------------------------------------------------------------
# See: `~/Library/Preferences/com.apple.dock.plist` or `defaults read com.apple.dock`
{
  flake.modules.darwin.dock = {lib, ...}: {
    system.defaults.dock = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.enable-spring-load-actions-on-all-items
      enable-spring-load-actions-on-all-items = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.appswitcher-all-displays
      appswitcher-all-displays = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.autohide
      autohide = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.autohide-delay
      autohide-delay = lib.mkDefault 0.24;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.autohide-time-modifier
      autohide-time-modifier = lib.mkDefault 1.0;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.dashboard-in-overlay
      dashboard-in-overlay = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.expose-animation-duration
      expose-animation-duration = lib.mkDefault 1.0;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.expose-group-apps
      expose-group-apps = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.largesize
      largesize = lib.mkDefault 16;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.launchanim
      launchanim = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.magnification
      magnification = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.mineffect
      mineffect = lib.mkDefault "scale";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.minimize-to-application
      minimize-to-application = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.mouse-over-hilite-stack
      mouse-over-hilite-stack = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.mru-spaces
      mru-spaces = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.orientation
      orientation = lib.mkDefault "bottom";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.persistent-apps
      persistent-apps = lib.mkBefore [
        {
          app = "/System/Applications/System Settings.app";
        }
      ];
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.scroll-to-open
      scroll-to-open = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.show-process-indicators
      show-process-indicators = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.show-recents
      show-recents = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.showAppExposeGestureEnabled
      showAppExposeGestureEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.showDesktopGestureEnabled
      showDesktopGestureEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.showLaunchpadGestureEnabled
      showLaunchpadGestureEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.showMissionControlGestureEnabled
      showMissionControlGestureEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.slow-motion-allowed
      slow-motion-allowed = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.static-only
      static-only = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.tilesize
      tilesize = lib.mkDefault 68;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-tl-corner
      # 13 - Lock Screen
      wvous-tl-corner = lib.mkDefault 13;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-tr-corner
      # 4 - Desktop
      wvous-tr-corner = lib.mkDefault 4;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-bl-corner
      # 2 - Mission Control
      wvous-bl-corner = lib.mkDefault 2;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.dock.wvous-br-corner
      # 1 - Disabled
      wvous-br-corner = lib.mkDefault 1;
    };
  };
}
