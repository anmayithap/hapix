# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > TUI > LazySSH]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-lazyssh = {lib, ...}: {
    programs.lazyssh = {
      enable = lib.mkForce true;
    };
  };
}
