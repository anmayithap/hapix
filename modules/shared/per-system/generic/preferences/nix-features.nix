# ----------------------------------------------------------------------------
# ## Generic Module: [Preferences > Nix Features]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.nix-features = {lib, ...}: {
    nix.settings.experimental-features = lib.mkBefore [
      "nix-command"
      "flakes"
    ];
  };
}
