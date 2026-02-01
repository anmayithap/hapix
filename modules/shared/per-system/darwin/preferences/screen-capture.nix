# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Screen Capture
# ----------------------------------------------------------------------------
# See: `~/Library/Preferences/com.apple.screencapture.plist`
{
  flake.modules.darwin.screen-capture = {lib, ...}: {
    system.defaults.screencapture = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.screencapture.include-date
      include-date = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.screencapture.target
      target = lib.mkDefault "clipboard";
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.screencapture.type
      type = lib.mkDefault "jpg";
    };
  };
}
