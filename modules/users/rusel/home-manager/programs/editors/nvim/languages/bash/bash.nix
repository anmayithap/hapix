{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.languages.bash = {
      enable = lib.mkDefault true;
    };
  };
}
