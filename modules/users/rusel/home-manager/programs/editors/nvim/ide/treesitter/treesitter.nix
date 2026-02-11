{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.treesitter = {
      enable = lib.mkDefault true;

      autotagHtml = lib.mkDefault true;

      fold = lib.mkDefault true;

      highlight = {
        enable = lib.mkDefault true;
      };

      indent = {
        enable = lib.mkDefault true;
      };

      addDefaultGrammars = lib.mkDefault true;
    };
  };
}
