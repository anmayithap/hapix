# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > yq]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-yq = {lib, ...}: {
    programs.yq = {
      enable = lib.mkForce true;
    };
  };
}
