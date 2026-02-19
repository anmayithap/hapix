# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > UI > Icons > mini.icons]
# Implementation
# ------------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    inherit (inputs.nvf.lib.nvim.lua) toLuaObject;

    cfg = config.programs.nvf.settings.vim.hapix.mini.icons;

    predicate = config.programs.nvf.enable && cfg.enable;

    setupOpts =
      cfg.setupOpts
      // {
        use_file_extension = lib.generators.mkLuaInline cfg.setupOpts.use_file_extension;
      };

    setupExpression = ''
      local icons = require("mini.icons")
      icons.setup(${toLuaObject setupOpts})

      icons.mock_nvim_web_devicons()

      HapixSched.later(icons.tweak_lsp_kind("${cfg.hooks.tweak_lsp_kind.mode}"))
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
    config = {
      assertions = [
        {
          assertion = cfg.enable && config.programs.nvf.settings.vim.runtimes.hapix-sched.enable;
          message = "hapix.sched must be enabled to use mini.icons";
        }
      ];

      programs.nvf.settings.vim = lib.mkIf predicate {
        mini.icons.enable = lib.mkForce false;

        extraPlugins = {
          mini-icons = {
            inherit (cfg) package;
            setup = finalSetupExpression;
          };
        };
      };
    };
  };
}
