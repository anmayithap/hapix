# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > TUI > LazySQL]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-lazysql = {lib, ...}: {
    programs.lazysql = {
      enable = lib.mkForce true;
    };
  };
}
