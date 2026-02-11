# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > zoxide]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-zoxide = {lib, ...}: {
    programs.zoxide = {
      enable = lib.mkForce true;
    };
  };
}
