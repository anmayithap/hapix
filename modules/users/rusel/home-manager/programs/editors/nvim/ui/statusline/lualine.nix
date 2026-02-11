{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.statusline.lualine = {
      enable = lib.mkDefault true;
      theme = lib.mkDefault "ayu_dark";
    };
  };
}
