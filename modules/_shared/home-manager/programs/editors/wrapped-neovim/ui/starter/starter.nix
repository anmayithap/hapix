# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Starter]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.starter = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "mini.starter";
      pname = lib.mkDefault "mini.starter";
    };
  };
}
