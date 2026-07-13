# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Services > Keyboard > SKHD]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-skhd = {lib, ...}: {
    services.skhd = {
      enable = lib.mkForce true;
    };
  };
}
