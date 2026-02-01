# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Login Window
# ----------------------------------------------------------------------------
# See: `~/Library/Preferences/com.apple.loginwindow.plist` or `defaults read com.apple.loginwindow`
{
  flake.modules.darwin.login-window = {lib, ...}: {
    system.defaults.loginwindow = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.loginwindow.DisableConsoleAccess
      DisableConsoleAccess = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.loginwindow.GuestEnabled
      GuestEnabled = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.loginwindow.PowerOffDisabledWhileLoggedIn
      PowerOffDisabledWhileLoggedIn = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.loginwindow.RestartDisabled
      RestartDisabled = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.loginwindow.RestartDisabledWhileLoggedIn
      RestartDisabledWhileLoggedIn = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.loginwindow.SHOWFULLNAME
      SHOWFULLNAME = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.loginwindow.ShutDownDisabled
      ShutDownDisabled = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.loginwindow.ShutDownDisabledWhileLoggedIn
      ShutDownDisabledWhileLoggedIn = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.loginwindow.SleepDisabled
      SleepDisabled = lib.mkDefault false;
    };
  };
}
