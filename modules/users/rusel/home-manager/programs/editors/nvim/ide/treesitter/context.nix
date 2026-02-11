{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.treesitter.context = {
      enable = lib.mkDefault true;
    };
  };
}
