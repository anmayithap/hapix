# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > fastfetch]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-fastfetch = {lib, ...}: {
    programs.fastfetch = {
      enable = lib.mkForce true;
    };
  };
}
