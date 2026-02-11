{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.visuals = {
      nvim-web-devicons = {
        enable = lib.mkDefault true;
      };
    };
  };
}
