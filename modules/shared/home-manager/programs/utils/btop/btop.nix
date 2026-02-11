# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > btop]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.btop = {lib, ...}: {
    programs.btop = {
      enable = lib.mkDefault false;
    };
  };
}
