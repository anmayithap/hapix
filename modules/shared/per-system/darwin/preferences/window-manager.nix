# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Window Manager
# ----------------------------------------------------------------------------
# See: `~/Library/Preferences/com.apple.WindowManager.plist`
{
  flake.modules.darwin.window-manager = {lib, ...}: {
    system.defaults.WindowManager = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.AppWindowGroupingBehavior
      # false - "One at a time"
      AppWindowGroupingBehavior = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.AutoHide
      AutoHide = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.EnableStandardClickToShowDesktop
      EnableStandardClickToShowDesktop = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.EnableTiledWindowMargins
      EnableTiledWindowMargins = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.EnableTilingByEdgeDrag
      EnableTilingByEdgeDrag = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.EnableTilingOptionAccelerator
      EnableTilingOptionAccelerator = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.EnableTopTilingByEdgeDrag
      EnableTopTilingByEdgeDrag = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.GloballyEnabled
      GloballyEnabled = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.HideDesktop
      HideDesktop = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.StageManagerHideWidgets
      StageManagerHideWidgets = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.StandardHideDesktopIcons
      StandardHideDesktopIcons = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.WindowManager.StandardHideWidgets
      StandardHideWidgets = lib.mkDefault false;
    };
  };
}
