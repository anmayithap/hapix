# ------------------------------------------------------------------------------
# Home Manager Module: [Programs > Editors > Neovim]
# ------------------------------------------------------------------------------
# Neovim configures by nvf (neovim flake) framework.
# Index: https://nvf.notashelf.dev/index.html
# Options: https://nvf.notashelf.dev/options.html
{
  flake.modules.homeManager.neovim = {lib, ...}: {
    programs.nvf = {
      enable = lib.mkDefault false;
      # ## Set $EDITOR variable to neovim
      defaultEditor = lib.mkDefault true;

      settings.vim.runtimes = {
        hapix.enable = lib.mkDefault true;
      };
    };
  };
}
