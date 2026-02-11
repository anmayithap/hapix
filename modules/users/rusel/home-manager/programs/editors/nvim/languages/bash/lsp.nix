{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.languages.bash.lsp = {
      enable = lib.mkDefault true;
    };
  };
}
