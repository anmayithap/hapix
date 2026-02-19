# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > UI > Colorscheme]
# Implementation
# ------------------------------------------------------------------------------
{
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.nvf.settings.vim.hapix.colorscheme;

    installers = {
      ayu = ''require("ayu").colorscheme()'';
    };

    installer = installers.${cfg.default};
  in {
    config.programs.nvf.settings.vim = {
      luaConfigPost = lib.mkAfter ''
        if not vim.g.vscode then
          ${installer}
        end
      '';
    };
  };
}
