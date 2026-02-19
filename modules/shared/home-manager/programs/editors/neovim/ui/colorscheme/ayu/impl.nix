# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > UI > Colorscheme > ayu]
# Implementation
# ------------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    inherit (inputs.nvf.lib.nvim.lua) toLuaObject;

    cfg = config.programs.nvf.settings.vim.hapix.colorscheme.ayu;

    predicate = config.programs.nvf.enable && cfg.enable;

    setupExpression = ''
      local colors = require("ayu.colors")
      colors.generate(${toLuaObject cfg.setupOpts.mirage})

      local ayu = require("ayu")
      ayu.setup(${toLuaObject cfg.setupOpts})
    '';

    finalSetupExpression =
      if cfg.vscode.enable
      then ''
        if not vim.g.vscode then
          ${setupExpression}
        end
      ''
      else setupExpression;
  in {
    config.programs.nvf.settings.vim = lib.mkIf predicate {
      extraPlugins = {
        neovim-ayu = {
          inherit (cfg) package;
          setup = finalSetupExpression;
        };
      };
    };
  };
}
