# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Navigation > Explorer]
# Implementation
# -----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.explorer;
  in {
    config.wrappers.neovim.specs.explorer = lib.mkIf cfg.enable {
      data = [
        (
          lib.optionals cfg.as_tree.enable {
            inherit (cfg.as_tree) name pname;
            data = builtins.getAttr cfg.as_tree.name (
              with pkgs.vimPlugins; {
                "nvim-tree" = nvim-tree-lua;
                "mini.files" = mini-files;
              }
            );
            lazy = builtins.getAttr cfg.as_tree.name {
              "nvim-tree" = true;
              "mini.files" = false;
            };
          }
        )
        (
          lib.optionals cfg.as_buffer.enable {
            inherit (cfg.as_buffer) name pname;
            data = builtins.getAttr cfg.as_buffer.name {
              "oil" = config.wrappers.neovim.nvim-lib.mkPlugin "oil.nvim" inputs.neovim-plugin-oil;
            };
            lazy = lib.mkDefault false;
          }
        )
        (
          lib.optionals cfg.as_buffer.enable {
            data = builtins.getAttr cfg.as_buffer.name {
              "oil" = config.wrappers.neovim.nvim-lib.mkPlugin "oil-git.nvim" inputs.neovim-plugin-oil-git;
            };
            lazy = lib.mkDefault true;
          }
        )
        (
          lib.optionals cfg.as_buffer.enable {
            data = builtins.getAttr cfg.as_buffer.name {
              "oil" = config.wrappers.neovim.nvim-lib.mkPlugin "oil-lsp-diagnostics.nvim" inputs.neovim-plugin-oil-lsp-diagnostics;
            };
            lazy = lib.mkDefault true;
          }
        )
      ];
      after = ["lze"];
    };
  };
}
