# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Navigation > Picker]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.picker = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "mini.pick";
      pname = lib.mkDefault "mini.pick";
    };
  };
}
