# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Colorscheme]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.colorscheme = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "ayu-dark";
      pname = lib.mkDefault "neovim-ayu";
    };
  };
}
