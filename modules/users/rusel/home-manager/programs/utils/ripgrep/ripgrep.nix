# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > ripgrep]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-ripgrep = {lib, ...}: {
    programs.ripgrep = {
      enable = lib.mkForce true;
    };
  };
}
