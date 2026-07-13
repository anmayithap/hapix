# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Development > mise]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-mise = {lib, ...}: {
    programs.mise = {
      enable = lib.mkForce true;
    };
  };
}
