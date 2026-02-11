# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > glow]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-glow = {lib, ...}: {
    programs.glow = {
      enable = lib.mkDefault true;
    };
  };
}
