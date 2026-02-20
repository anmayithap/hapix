# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > Helpers > mini.clue]
# Declaration
# ------------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.neovim = {lib, ...}: let
    inherit (inputs.nvf.lib.nvim.types) luaInline;

    # ## Vim map modes. See `:help map-modes`
    modes = lib.types.enum [
      "n" # Normal
      "i" # Insert
      "c" # Command-line
      "v" # Visual and Select
      "x" # Visual
      "s" # Select
      "o" # Operator-pending
      "t" # Terminal
      "l" # Insert, Command-line and Lang-Arg
    ];

    # ## Keybinding type submodule
    mapType = with lib.types;
      submodule {
        options = {
          mode = lib.mkOption {
            type = either modes (listOf modes);
            default = "n";
            defaultText = "n";
            description = ''
              The short-name of the mode to set the key mapping for.
              Passing an empty string is the equivalent of `:map`.

              See `:help map-modes` for a list of modes.
            '';
            example = lib.literalExpression ''
              {
                mode = ["n" "i"];
              }
            '';
          };

          keys = lib.mkOption {
            type = str;
            default = "";
            defaultText = "";
            description = "The key that triggers this key map.";
            example = lib.literalExpression ''
              {
                keys = "<Leader>";
              }
            '';
          };

          desc = lib.mkOption {
            type = nullOr str;
            default = null;
            description = ''
              A description of this keybind,
              to be shown in mini.clue,
              if you have it enabled.
            '';
          };

          postkeys = lib.mkOption {
            type = nullOr str;
            default = null;
            description = "A sequence of keys to be executed after this keybind is triggered.";
            example = lib.literalExpression ''"<C-c>'';
          };
        };
      };

    # ## Lua window.config table
    # See: https://neovim.io/doc/user/api.html#nvim_open_win()
    windowConfigType = with lib.types;
      submodule {
        options = {
          anchor = lib.mkOption {
            type = enum ["NW" "NE" "SW" "SE"];
            default = "SE";
            defaultText = "SE";
            description = ''
              Anchor position of the window.

              Can be one of:
                - "NW" (top left)
                - "NE" (top right)
                - "SW" (bottom left)
                - "SE" (bottom right)
            '';
            example = lib.literalExpression ''
              {
                anchor = "NW";
              }
            '';
          };

          border = lib.mkOption {
            type = enum ["bold" "double" "none" "rounded" "shadow" "single" "solid"];
            default = "rounded";
            defaultText = "rounded";
            description = ''
              Border style.

              Can be one of:
                - "bold"    (bold-line border)
                - "double"  (double-line border)
                - "none"    (no border)
                - "rounded" (like "single", but with rounded corners)
                - "shadow"  (drop shadow effect, by blending with background)
                - "single"  (single-line border)
                - "solid"   (adds padding by a single whitespace cell)
            '';
            example = lib.literalExpression ''
              {
                border = "rounded";
              }
            '';
          };

          width = lib.mkOption {
            type = either int (enum ["auto"]);
            default = "auto";
            defaultText = "auto";
            description = ''
              Width of the window (Columns)

              "auto" leading to window width being computed automatically based on its content.
            '';
            example = lib.literalExpression ''
              {
                width = 30;
              }
            '';
          };
        };
      };

    # ## Lua window table
    # See: https://nvim-mini.org/mini.nvim/doc/mini-clue.html#miniclue.config-window
    windowType = with lib.types;
      submodule {
        options = {
          delay = lib.mkOption {
            type = int;
            default = 500;
            defaultText = "500";
            description = "Delay before showing the popup menu (in milliseconds)";
            example = lib.literalExpression ''
              {
                delay = 1000;
              }
            '';
          };

          config = lib.mkOption {
            type = windowConfigType;
            default = {};
            defaultText = "{}";
            description = "Window configuration";
            example = lib.literalExpression ''{ width = 30; anchor = "SW"; }'';
          };

          scroll_down = lib.mkOption {
            type = str;
            default = "<C-d>";
            defaultText = "<C-d>";
            description = "Scroll popup menu down [mini.clue]";
            example = lib.literalExpression ''"<C-d>"'';
          };
          scroll_up = lib.mkOption {
            type = str;
            default = "<C-u>";
            defaultText = "<C-u>";
            description = "Scroll popup menu up [mini.clue]";
            example = lib.literalExpression ''"<C-u>"'';
          };
        };
      };

    # ## built-in clues configuration
    # from supported `mini.clue` standard mapping handlers (g, z, registers, marks, etc.)
    # These parameters automatically configure clues and triggers for these handlers.
    builtinCluesType = with lib.types;
      submodule {
        options = {
          # ## Enable builtin completion `<C-x>` mapping
          builtin_completion.enable = lib.mkEnableOption "`C-x` mapping";
          # ## Enable `g` mapping
          g.enable = lib.mkEnableOption "`g` mapping";
          # ## Enable `[` and `]` mappings
          square_brackets.enable = lib.mkEnableOption "`[` and `]` mappings";
          # ## Enable marks '`' and `'` mappings
          marks.enable = lib.mkEnableOption "'`' and `'` mappings";
          # ## Enable registers `"` and `<C-r>` mappings
          registers = {
            enable = lib.mkEnableOption ''`"` and `<C-r>` mappings'';

            show_contents = lib.mkEnableOption "Show contents of all possible registers";
          };
          # ## Enable windows `<C-w>` mapping
          windows = {
            enable = lib.mkEnableOption "`<C-w>` mappings";

            submodule_move = lib.mkEnableOption "change layout commands a sub mode";
            submodule_navigate = lib.mkEnableOption "change focus commands a sub mode";
            submodule_resize = lib.mkEnableOption "change size commands a sub mode";
          };
          # ## Enable `z` mapping
          z.enable = lib.mkEnableOption "`z` mapping";
        };
      };

    triggersType = with lib.types; listOf mapType;

    cluesType = with lib.types; listOf (oneOf [luaInline mapType]);
  in {
    options.programs.nvf.settings.vim.mini.clue = {
      vscode.enable = lib.mkEnableOption "vscode disabling wrapper";

      builtin-clues = lib.mkOption {
        type = builtinCluesType;
        default = {};
        defaultText = "{}";
        description = "Built-in clues configuration";
        example = lib.literalExpression ''
          builtin-clues = {
            g.enable = true;
          };
        '';
      };

      setupOpts = {
        window = lib.mkOption {
          type = windowType;
          default = {};
          defaultText = "{}";
          description = "Window configuration";
          example = lib.literalExpression ''
            {
              delay = 1000;
            }
          '';
        };

        triggers = lib.mkOption {
          type = triggersType;
          default = [];
          defaultText = "{}";
          description = "Triggers configuration";
          example = lib.literalExpression ''
            triggers = {
              {
                mode = "n";
                keys = "g";
              }
            };
          '';
          # ## Flatting trigger modes
          apply = triggers:
            lib.concatMap (
              t:
                if lib.isList t.mode
                then map (m: t // {mode = m;}) t.mode
                else [t]
            )
            triggers;
        };

        clues = lib.mkOption {
          type = cluesType;
          default = [];
          defaultText = "[]";
          description = "Clues configuration";
          example = lib.literalExpression ''
            {
              mode = "n";
              keys = "<leader>b";
              desc = "+Buffer";
            }
          '';
        };
      };
    };
  };
}
