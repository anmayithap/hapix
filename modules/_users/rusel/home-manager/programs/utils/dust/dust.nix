# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > dust]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-dust = {lib, ...}: {
    programs.dust = {
      enable = lib.mkForce true;
    };
  };
}
