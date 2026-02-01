# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Finder
# ----------------------------------------------------------------------------
# See: `~/Library/Preferences/com.apple.finder.plist` or `defaults read com.apple.finder`
{
  flake.modules.darwin.finder = {lib, ...}: {
    system.defaults.finder = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.AppleShowAllExtensions
      AppleShowAllExtensions = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.AppleShowAllFiles
      AppleShowAllFiles = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.CreateDesktop
      CreateDesktop = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.FXDefaultSearchScope
      # SCcf - Current Folder
      FXDefaultSearchScope = lib.mkDefault "SCcf";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.FXEnableExtensionChangeWarning
      FXEnableExtensionChangeWarning = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.FXPreferredViewStyle
      # clmv - Column View
      FXPreferredViewStyle = lib.mkDefault "clmv";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.FXRemoveOldTrashItems
      # Note: Remove items in the trash after 30 days
      FXRemoveOldTrashItems = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.NewWindowTarget
      NewWindowTarget = lib.mkDefault "Home";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.QuitMenuItem
      QuitMenuItem = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.ShowExternalHardDrivesOnDesktop
      ShowExternalHardDrivesOnDesktop = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.ShowHardDrivesOnDesktop
      ShowHardDrivesOnDesktop = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.ShowMountedServersOnDesktop
      ShowMountedServersOnDesktop = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.ShowPathbar
      ShowPathbar = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.ShowRemovableMediaOnDesktop
      ShowRemovableMediaOnDesktop = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder.ShowStatusBar
      ShowStatusBar = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder._FXEnableColumnAutoSizing
      _FXEnableColumnAutoSizing = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder._FXShowPosixPathInTitle
      _FXShowPosixPathInTitle = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder._FXSortFoldersFirst
      _FXSortFoldersFirst = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.finder._FXSortFoldersFirstOnDesktop
      _FXSortFoldersFirstOnDesktop = lib.mkDefault true;
    };
  };
}
