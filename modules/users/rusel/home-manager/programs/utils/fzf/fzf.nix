# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > fzf]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-fzf = {lib, ...}: {
    programs.fzf = {
      enable = lib.mkForce true;
    };
  };
}
