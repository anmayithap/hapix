_: let
  system = {lib, ...}: {
    system.defaults.WindowManager = {
      AppWindowGroupingBehavior = lib.mkDefault true;
      AutoHide = lib.mkDefault false;
      GloballyEnabled = lib.mkDefault false;
      HideDesktop = lib.mkDefault true;
      StageManagerHideWidgets = lib.mkDefault false;
      StandardHideDesktopIcons = lib.mkDefault true;
      StandardHideWidgets = lib.mkDefault false;
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
