# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Icons]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.icons = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "mini.icons";
      pname = lib.mkDefault "mini.icons";
    };
  };
}
