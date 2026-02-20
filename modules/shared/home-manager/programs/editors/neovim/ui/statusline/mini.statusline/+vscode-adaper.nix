# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > UI > Statusline > Mini.statusline]
# Adapter for VSCode
# ------------------------------------------------------------------------------
{
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.nvf.settings.vim.mini.statusline;

    predicate = config.programs.nvf.enable && cfg.enable && cfg.vscode.enable;
  in {
    options.programs.nvf.settings.vim.mini.statusline.vscode.enable = lib.mkEnableOption "vscode disabling wrapper";

    config.programs.nvf.settings.vim = lib.mkIf predicate {
      pluginRC = {
        mini-statusline = lib.mkMerge [
          (lib.mkBefore ''if not vim.g.vscode then'')
          (lib.mkAfter ''end'')
        ];
      };
    };
  };
}
