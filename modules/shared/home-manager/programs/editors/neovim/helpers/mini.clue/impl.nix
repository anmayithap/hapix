# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > Helpers > mini.clue]
# Implementation
# ------------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    inherit (inputs.nvf.lib.nvim.lua) toLuaObject;

    cfg = config.programs.nvf.settings.vim.mini.clue;

    predicate = config.programs.nvf.enable && cfg.enable;

    gTriggers = [
      {
        mode = ["n" "x"];
        keys = "g";
      }
    ];

    builtinCompletionTriggers = [
      {
        mode = "i";
        keys = "<C-x>";
      }
    ];

    squareBracketsTriggers = [
      {
        mode = ["n" "x"];
        keys = "[";
      }
      {
        mode = ["n" "x"];
        keys = "]";
      }
    ];

    marksTriggers = [
      {
        mode = ["n" "x"];
        keys = "'";
      }
      {
        mode = ["n" "x"];
        keys = "`";
      }
    ];

    registersTriggers = [
      {
        mode = ["n" "x"];
        keys = ''"'';
      }
      {
        mode = ["i" "x"];
        keys = "<C-r>";
      }
    ];

    windowTriggers = [
      {
        mode = "n";
        keys = "<C-w>";
      }
    ];

    zTriggers = [
      {
        mode = ["n" "x"];
        keys = "z";
      }
    ];

    finalTriggers =
      (lib.optionals cfg.builtin-clues.g.enable gTriggers)
      ++ (lib.optionals cfg.builtin-clues.builtin_completion.enable builtinCompletionTriggers)
      ++ (lib.optionals cfg.builtin-clues.square_brackets.enable squareBracketsTriggers)
      ++ (lib.optionals cfg.builtin-clues.marks.enable marksTriggers)
      ++ (lib.optionals cfg.builtin-clues.registers.enable registersTriggers)
      ++ (lib.optionals cfg.builtin-clues.windows.enable windowTriggers)
      ++ (lib.optionals cfg.builtin-clues.z.enable zTriggers);

    gClues = [
      (lib.mkLuaInline "miniclue.gen_clues.g()")
    ];

    builtinCompletionClues = [
      (lib.mkLuaInline "miniclue.gen_clues.builtin_completion()")
    ];

    squareBracketsClues = [
      (lib.mkLuaInline "miniclue.gen_clues.square_brackets()")
    ];

    marksClues = [
      (lib.mkLuaInline "miniclue.gen_clues.marks()")
    ];

    registersClues = [
      (
        lib.mkLuaInline ''
          miniclue.gen_clues.registers(
            {
              show_contents=${toLuaObject cfg.builtin-clues.registers.show_contents},
            }
          )''
      )
    ];

    windowClues = [
      (
        lib.mkLuaInline ''
          miniclue.gen_clues.windows(
            {
              submodule_move=${toLuaObject cfg.builtin-clues.windows.submodule_move},
              submodule_navigate=${toLuaObject cfg.builtin-clues.windows.submodule_navigate},
              submodule_resize=${toLuaObject cfg.builtin-clues.windows.submodule_resize},
            }
          )''
      )
    ];

    zClues = [
      (lib.mkLuaInline "miniclue.gen_clues.z()")
    ];

    finalClues =
      (lib.optionals cfg.builtin-clues.g.enable gClues)
      ++ (lib.optionals cfg.builtin-clues.builtin_completion.enable builtinCompletionClues)
      ++ (lib.optionals cfg.builtin-clues.square_brackets.enable squareBracketsClues)
      ++ (lib.optionals cfg.builtin-clues.marks.enable marksClues)
      ++ (lib.optionals cfg.builtin-clues.registers.enable registersClues)
      ++ (lib.optionals cfg.builtin-clues.windows.enable windowClues)
      ++ (lib.optionals cfg.builtin-clues.z.enable zClues);
  in {
    config.programs.nvf.settings.vim = lib.mkIf predicate {
      mini.clue = {
        setupOpts = {
          clues = lib.mkAfter finalClues;
          triggers = lib.mkAfter finalTriggers;
        };
      };

      pluginRC.mini-clue = lib.mkMerge [
        (lib.mkOrder 600 ''miniclue = require("mini.clue")'')
        (lib.mkIf cfg.vscode.enable (lib.mkBefore ''if not vim.g.vscode then''))
        (lib.mkIf cfg.vscode.enable (lib.mkAfter ''end''))
      ];
    };
  };
}
