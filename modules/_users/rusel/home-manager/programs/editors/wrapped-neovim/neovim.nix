# -----------------------------------------------------------------------------
# ## Rusel Home Manager: [Programs > Editors > wrapped-neovim]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-wrapped-neovim = {lib, ...}: {
    wrappers.neovim = {
      enable = lib.mkForce true;
    };
  };
}
