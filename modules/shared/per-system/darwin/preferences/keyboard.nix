# ----------------------------------------------------------------------------
# ## Darwin System Preferences Module: Keyboard
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.keyboard = {lib, ...}: {
    system.keyboard = {
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.keyboard.enableKeyMapping
      enableKeyMapping = lib.mkDefault true;
      # See: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.keyboard.remapCapsLockToControl
      remapCapsLockToControl = lib.mkDefault true;
    };
  };
}
