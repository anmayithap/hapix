# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > UI > Colorscheme > ayu]
# ------------------------------------------------------------------------------
# See: https://github.com/Shatur/neovim-ayu
{
  flake.modules.homeManager.neovim = {lib, ...}: {
    programs.nvf.settings.vim.hapix.colorscheme.ayu = {
      # ## Enable setup 'neovim-ayu' color scheme by default.
      enable = lib.mkDefault true;
      # ## Wrap package setups for vscode using
      vscode.enable = lib.mkDefault true;

      setupOpts = {
        mirage = lib.mkDefault false;
        terminal = lib.mkDefault true;
      };
    };
  };
}
