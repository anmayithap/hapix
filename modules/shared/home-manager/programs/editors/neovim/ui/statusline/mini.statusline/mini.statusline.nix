# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > UI > Statusline > Mini.statusline]
# ------------------------------------------------------------------------------
# See: https://nvim-mini.org/mini.nvim/doc/mini-statusline.html
{
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    lualineCfg = config.programs.nvf.settings.vim.statusline.lualine;
    miniStatusLineCfg = config.programs.nvf.settings.vim.mini.statusline;
  in {
    assertions = [
      {
        assertion = !(miniStatusLineCfg.enable && lualineCfg.enable);
        message = "mini.statusline is incompatible with lualine. Please disable one of them.";
      }
    ];

    programs.nvf.settings.vim.mini.statusline = {
      enable = lib.mkDefault true;

      vscode.enable = lib.mkDefault true;

      setupOpts = {
        use_icons = lib.mkDefault true;

        content = {
          active = lib.generators.mkLuaInline ''
            function()
              local MiniStatusLine = require('mini.statusline')

              local mode, mode_hl = MiniStatusLine.section_mode({ trunc_width = 120 })
              local git = MiniStatusline.section_git({ trunc_width = 40 })
              local diff = MiniStatusline.section_diff({ trunc_width = 75 })

              return MiniStatusLine.combine_groups({
                { hl = mode_hl, strings = { string.upper(mode) } },
                { hl = 'MiniStatuslineDevinfo', strings = { git, diff } },
                "%<",
              })
            end
          '';
        };
      };
    };
  };
}
