# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > eza]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-eza = {lib, ...}: {
    programs.eza = {
      enable = lib.mkForce true;
    };
  };
}
