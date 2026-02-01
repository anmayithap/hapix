# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Extra Clock
# ----------------------------------------------------------------------------
# See: `~/Library/Preferences/com.apple.menuextra.clock.plist` or `defaults read com.apple.menuextra.clock`
{
  flake.modules.darwin.extra-clock = {lib, ...}: {
    system.defaults.menuExtraClock = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.menuExtraClock.FlashDateSeparators
      FlashDateSeparators = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.menuExtraClock.IsAnalog
      IsAnalog = lib.mkDefault false;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.menuExtraClock.Show24Hour
      Show24Hour = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.menuExtraClock.ShowDayOfMonth
      ShowDayOfMonth = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.menuExtraClock.ShowDayOfWeek
      ShowDayOfWeek = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.menuExtraClock.ShowSeconds
      ShowSeconds = lib.mkDefault true;
    };
  };
}
