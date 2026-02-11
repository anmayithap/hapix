{
  flake.modules.homeManager.rusel-editors = {
    lib,
    pkgs,
    ...
  }: {
    programs.nvf.settings.vim = {
      theme.enable = lib.mkForce false;

      extraPlugins = with pkgs.vimPlugins; {
        ayu-neovim = {
          package = lib.mkForce neovim-ayu;
          setup = ''
            require('ayu').setup({
              mirge = false,
              terminal = true,
            })

            vim.cmd.colorscheme('ayu')
          '';
        };
      };
    };
  };
}
