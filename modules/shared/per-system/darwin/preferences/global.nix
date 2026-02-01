# ----------------------------------------------------------------------------
# ## Darwin Global Preferences Module
# ----------------------------------------------------------------------------
# See: `defaults read -globalDomain`
{
  flake.modules.darwin.global = {lib, ...}: {
    system.defaults.".GlobalPreferences" = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults._.GlobalPreferences_._com.apple.mouse.scaling_
      "com.apple.mouse.scaling" = lib.mkDefault 5.;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults._.GlobalPreferences_._com.apple.sound.beep.sound_
      "com.apple.sound.beep.sound" = lib.mkDefault "/System/Library/Sounds/Frog.aiff";
    };
  };
}
