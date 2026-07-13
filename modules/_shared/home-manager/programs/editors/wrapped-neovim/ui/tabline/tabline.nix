# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Tabline]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.tabline = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "mini.tabline";
      pname = lib.mkDefault "mini.tabline";
    };
  };
}
