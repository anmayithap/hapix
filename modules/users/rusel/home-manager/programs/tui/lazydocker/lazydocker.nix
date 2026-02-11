# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > TUI > LazyDocker]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-lazydocker = {lib, ...}: {
    programs.lazydocker = {
      enable = lib.mkForce true;
    };
  };
}
