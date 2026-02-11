# ----------------------------------------------------------------------------
# ## Darwin Module: [Preferences > Control Center]
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
      Bluetooth = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.Display
      Display = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.FocusModes
      FocusModes = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.NowPlaying
      NowPlaying = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.controlcenter.Sound
      Sound = lib.mkDefault false;
    };
  };
}
