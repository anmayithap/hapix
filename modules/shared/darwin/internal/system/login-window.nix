_: let
  system = {lib, ...}: {
    system.defaults.loginwindow = {
      GuestEnabled = lib.mkDefault false;
      PowerOffDisabledWhileLoggedIn = lib.mkDefault false;
      RestartDisabled = lib.mkDefault false;
      RestartDisabledWhileLoggedIn = lib.mkDefault false;
      SHOWFULLNAME = lib.mkDefault false;
      ShutDownDisabled = lib.mkDefault false;
      ShutDownDisabledWhileLoggedIn = lib.mkDefault false;
      SleepDisabled = lib.mkDefault false;
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
