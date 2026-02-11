{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.languages.nix = {
      enable = lib.mkDefault true;
    };
  };
}
