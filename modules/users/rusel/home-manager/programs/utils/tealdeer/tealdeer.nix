# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > tealdeer]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-tealdeer = {lib, ...}: {
    programs.tealdeer = {
      enable = lib.mkForce true;
    };
  };
}
