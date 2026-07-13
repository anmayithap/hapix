# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > TUI > lazygit]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.lazygit = {lib, ...}: {
    programs.lazygit = {
      enable = lib.mkDefault false;
    };
  };
}
