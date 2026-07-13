# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > starship]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-starship = {lib, ...}: {
    programs.starship = {
      enable = lib.mkForce true;
    };
  };
}
