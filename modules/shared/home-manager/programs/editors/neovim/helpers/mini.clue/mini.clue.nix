# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > Helpers > mini.clue]
# ------------------------------------------------------------------------------
# See: https://nvim-mini.org/mini.nvim/doc/mini-clue.html
{
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    whichKeyCfg = config.programs.nvf.settings.vim.binds.whichKey;
    miniClueCfg = config.programs.nvf.settings.vim.mini.clue;
  in {
    assertions = [
      {
        assertion = !(whichKeyCfg.enable && miniClueCfg.enable);
        message = "mini.clue is incompatible with which-key. Please disable one of them.";
      }
    ];

    programs.nvf.settings.vim.mini.clue = {
      enable = lib.mkDefault true;

      vscode.enable = lib.mkDefault true;

      builtin-clues = {
        g.enable = lib.mkDefault true;
        builtin_completion.enable = lib.mkDefault true;
        square_brackets.enable = lib.mkDefault true;
        marks.enable = lib.mkDefault true;
        registers = {
          enable = lib.mkDefault true;
          show_contents = lib.mkDefault true;
        };
        windows = {
          enable = lib.mkDefault true;
          submodule_move = lib.mkDefault true;
          submodule_navigate = lib.mkDefault true;
          submodule_resize = lib.mkDefault true;
        };
        z.enable = lib.mkDefault true;
      };

      setupOpts = {
        triggers = lib.mkBefore [
          {
            mode = ["n" "x"];
            keys = "<leader>";
          }
          {
            mode = ["n" "x"];
            keys = "<localleader>";
          }
        ];
      };
    };
  };
}
