# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > TUI > LazyGit]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-lazygit = {lib, ...}: {
    programs.lazygit = {
      enable = lib.mkForce true;
    };
  };
}
