# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Control Center
# ----------------------------------------------------------------------------
# See: `~/Library/Preferences/ByHost/com.apple.controlcenter.plist` or `defaults read com.apple.controlcenter`
{
  flake.modules.darwin.control-center = {lib, ...}: {
    system.defaults.controlcenter = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.AirDrop
      AirDrop = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.BatteryShowPercentage
      BatteryShowPercentage = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.Bluetooth
      # 24 - Hide icon in menu bar
      Bluetooth = lib.mkDefault 24;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.Display
      # 24 - Hide icon in menu bar
      Display = lib.mkDefault 24;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.FocusModes
      # 24 - Hide icon in menu bar
      FocusModes = lib.mkDefault 24;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.NowPlaying
      # 24 - Hide icon in menu bar
      NowPlaying = lib.mkDefault 24;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.Sound
      # 24 - Hide icon in menu bar
      Sound = lib.mkDefault 24;
    };
  };
}
