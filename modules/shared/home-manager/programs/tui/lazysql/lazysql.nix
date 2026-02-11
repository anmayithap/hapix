# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > TUI > lazysql]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.lazysql = {lib, ...}: {
    programs.lazysql = {
      enable = lib.mkDefault false;
    };
  };
}
