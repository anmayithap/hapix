_: let
  system = {lib, ...}: {
    system.defaults.finder = {
      AppleShowAllExtensions = lib.mkDefault true;
      AppleShowAllFiles = lib.mkDefault true;
      CreateDesktop = lib.mkDefault false;
      FXPreferredViewStyle = lib.mkDefault "clmv";
      FXDefaultSearchScope = lib.mkDefault "SCev";
      FXEnableExtensionChangeWarning = lib.mkDefault true;
      FXRemoveOldTrashItems = lib.mkDefault true;
      NewWindowTarget = lib.mkDefault "Home";
      ShowExternalHardDrivesOnDesktop = lib.mkDefault false;
      ShowHardDrivesOnDesktop = lib.mkDefault false;
      ShowMountedServersOnDesktop = lib.mkDefault false;
      ShowPathbar = lib.mkDefault true;
      ShowRemovableMediaOnDesktop = lib.mkDefault false;
      ShowStatusBar = lib.mkDefault true;
      _FXShowPosixPathInTitle = lib.mkDefault true;
      _FXSortFoldersFirst = lib.mkDefault true;
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
