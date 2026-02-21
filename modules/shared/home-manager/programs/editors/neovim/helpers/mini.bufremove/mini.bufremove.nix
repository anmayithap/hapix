# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > Helpers > mini.bufremove]
# ------------------------------------------------------------------------------
# See: https://nvim-mini.org/mini.nvim/doc/mini-bufremove.html
{
  flake.modules.homeManager.neovim = {lib, ...}: {
    programs.nvf.settings.vim.mini.bufremove = {
      enable = lib.mkDefault true;
      setupOpts = {
        # ## Whether to disable showing non-error feedback
        silent = true;
      };
    };
  };
}
