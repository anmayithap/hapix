# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > IDE > Completion]
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    wrappers.neovim.settings.completion = {
      enable = lib.mkDefault true;
      name = lib.mkDefault "mini.completion";
      pname = lib.mkDefault "mini.completion";
    };
  };
}
