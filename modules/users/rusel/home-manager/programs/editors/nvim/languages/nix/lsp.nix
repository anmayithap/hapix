{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.languages.nix.lsp = {
      enable = lib.mkDefault true;
    };
  };
}
