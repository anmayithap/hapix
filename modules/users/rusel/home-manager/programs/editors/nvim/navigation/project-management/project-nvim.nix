{inputs, ...}: {
  flake.modules.homeManager.rusel-editors = {
    lib,
    pkgs,
    config,
    ...
  }: let
    nvf-lib = inputs.nvf.lib.nvim;

    setupOpts = {};
  in {
    programs.nvf.settings.vim = {
      extraPlugins.project-nvim = {
        package = pkgs.vimPlugins.project-nvim;
        setup = ''
          require('project').setup(${nvf-lib.lua.toLuaObject setupOpts})
        '';
      };

      lazy.plugins.telescope = lib.mkIf config.programs.nvf.settings.vim.telescope.enable {
        keys = lib.mkAfter [
          (nvf-lib.binds.mkKeymap "n" "<leader>fp" ":Telescope projects<CR>" {desc = "Find projects [Telescope]";})
        ];
      };

      telescope.extensions = lib.mkAfter [
        {
          name = "projects";
          setup = {
            projects = {
              inherit (config.programs.nvf.settings.vim.telescope.setupOpts.defaults) prompt_prefix;
            };
          };
        }
      ];
    };
  };
}
