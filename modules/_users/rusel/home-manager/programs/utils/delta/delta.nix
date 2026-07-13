# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > delta]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-delta = {lib, ...}: {
    programs.delta = {
      enable = lib.mkForce true;
    };
  };
}
