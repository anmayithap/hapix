# ----------------------------------------------------------------------------
# ## Nix Features Preferences Module: Configures the Nix Features preferences
# ----------------------------------------------------------------------------
{
  flake.modules.generic.nix-features = {lib, ...}: {
    nix.settings.experimental-features = lib.mkBefore [
      "nix-command"
      "flakes"
    ];
  };
}
