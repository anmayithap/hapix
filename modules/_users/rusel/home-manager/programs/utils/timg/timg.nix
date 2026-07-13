# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > timg]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-timg = {lib, ...}: {
    programs.timg = {
      enable = lib.mkDefault true;
    };
  };
}
