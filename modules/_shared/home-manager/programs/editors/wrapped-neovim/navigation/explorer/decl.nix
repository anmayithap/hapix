# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Navigation > Explorer]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.explorer = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "explorer";

          default = lib.mkOption {
            type = lib.types.enum ["as_tree" "as_buffer"];
            default = "as_buffer";
            defaultText = ''"as_buffer"'';
            description = "The default explorer.";
          };

          as_tree = lib.mkOption {
            type = lib.types.submodule {
              options = {
                enable = lib.mkEnableOption "tree-like explorer";
                name = lib.mkOption {
                  type = lib.types.enum ["nvim-tree" "mini.files"];
                  default = "nvim-tree";
                  defaultText = ''"nvim-tree"'';
                  description = "Name of tree-like neovim explorer.";
                };
                pname = lib.mkOption {
                  type = lib.types.enum ["nvim-tree.lua" "mini.files"];
                  default = "nvim-tree.lua";
                  defaultText = ''"nvim-tree.lua"'';
                  description = "Plugin name of tree-like neovim explorer.";
                };
              };
            };
            default = {};
            defaultText = ''{}'';
            description = "Configure tree-like neovim explorer.";
          };

          as_buffer = lib.mkOption {
            type = lib.types.submodule {
              options = {
                enable = lib.mkEnableOption "buffer-like explorer";
                name = lib.mkOption {
                  type = lib.types.enum ["oil"];
                  default = "oil";
                  defaultText = ''"oil"'';
                  description = "Name of buffer-like neovim explorer.";
                };
                pname = lib.mkOption {
                  type = lib.types.enum ["oil.nvim"];
                  default = "oil.nvim";
                  defaultText = ''"oil.nvim"'';
                  description = "Plugin name of buffer-like neovim explorer.";
                };
              };
            };
            default = {};
            defaultText = ''{}'';
            description = "Configure buffer-like neovim explorer.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The explorer module.";
    };
  };
}
