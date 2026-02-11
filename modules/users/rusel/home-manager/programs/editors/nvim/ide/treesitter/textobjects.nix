{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.treesitter.textobjects = {
      enable = lib.mkDefault true;
    };
  };
}
