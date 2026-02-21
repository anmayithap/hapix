# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > Helpers > mini.bufremove]
# Implementation
# ------------------------------------------------------------------------------
{
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.nvf.settings.vim.mini.bufremove;
  in {
    config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
      pluginRC.mini-bufremove = lib.mkIf cfg.vscode.enable (
        lib.mkMerge [
          (lib.mkBefore ''if not vim.g.vscode then'')
          (lib.mkAfter ''end'')
        ]
      );
    };
  };
}
