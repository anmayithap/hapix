# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: HI Tool Box
# ----------------------------------------------------------------------------
# See: `~/Library/Preferences/com.apple.HIToolbox.plist` or `defaults read com.apple.HIToolbox`
{
  flake.modules.darwin.hi-tool-box = {lib, ...}: {
    system.defaults.hitoolbox = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.hitoolbox.AppleFnUsageType
      AppleFnUsageType = lib.mkDefault "Change Input Source";
    };
  };
}
