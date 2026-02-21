# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > Helpers > mini.bufremove]
# Declaration
# ------------------------------------------------------------------------------
{
  flake.modules.homeManager.neovim = {lib, ...}: {
    options.programs.nvf.settings.vim.mini.bufremove = {
      vscode.enable = lib.mkEnableOption "vscode disabling wrapper";
    };
  };
}
