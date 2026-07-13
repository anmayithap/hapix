# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Helpers > Deferral]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.deferral = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "lze";
      pname = lib.mkDefault "lze";
    };
  };
}
