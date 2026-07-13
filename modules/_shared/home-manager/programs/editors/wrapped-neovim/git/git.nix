# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Git]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.git = {
      enable = lib.mkDefault true;
      git = {
        enable = lib.mkDefault true;
        name = lib.mkDefault "mini.git";
        pname = lib.mkDefault "mini.git";
      };
      diff = {
        enable = lib.mkDefault true;
        name = lib.mkDefault "mini.diff";
        pname = lib.mkDefault "mini.diff";
      };
    };
  };
}
