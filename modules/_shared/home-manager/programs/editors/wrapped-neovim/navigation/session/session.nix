# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Navigation > Session]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.session = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "mini.sessions";
      pname = lib.mkDefault "mini.sessions";
    };
  };
}
