# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > btop]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-btop = {lib, ...}: {
    programs.btop = {
      enable = lib.mkForce true;
    };
  };
}
