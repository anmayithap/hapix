# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Helpers > Clues]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.clues = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "mini.clue";
      pname = lib.mkDefault "mini.clue";
    };
  };
}
