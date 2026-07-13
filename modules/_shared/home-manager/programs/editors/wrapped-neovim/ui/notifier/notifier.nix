# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Helpers > Notifier]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.notifier = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "mini.notify";
      pname = lib.mkDefault "mini.notify";
    };
  };
}
