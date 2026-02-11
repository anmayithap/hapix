# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Development > mise]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.mise = {lib, ...}: {
    programs.mise = {
      enable = lib.mkDefault false;
    };
  };
}
