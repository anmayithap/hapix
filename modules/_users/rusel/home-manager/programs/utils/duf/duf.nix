# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > duf]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-duf = {lib, ...}: {
    programs.duf = {
      enable = lib.mkForce true;
    };
  };
}
