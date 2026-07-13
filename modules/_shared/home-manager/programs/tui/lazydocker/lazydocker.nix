# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > TUI > lazydocker]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.lazydocker = {lib, ...}: {
    programs.lazydocker = {
      enable = lib.mkDefault false;
    };
  };
}
