# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Shells > fish]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-fish = {lib, ...}: {
    programs.fish.enable = lib.mkForce true;
  };
}
