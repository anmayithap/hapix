# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > XDG]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-xdg = {lib, ...}: {
    xdg.enable = lib.mkForce true;
  };
}
