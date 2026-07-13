# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Statusline]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.statusline = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "mini.statusline";
      pname = lib.mkDefault "mini.statusline";
    };
  };
}
