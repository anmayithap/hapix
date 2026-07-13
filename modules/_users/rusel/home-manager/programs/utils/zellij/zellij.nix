# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > zellij]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-zellij = {lib, ...}: {
    programs.zellij = {
      enable = lib.mkForce true;
    };
  };
}
