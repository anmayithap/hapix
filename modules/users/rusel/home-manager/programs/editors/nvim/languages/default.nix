{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.languages = {
      enableTreesitter = lib.mkDefault true;
      enableDAP = lib.mkDefault true;
      enableExtraDiagnostics = lib.mkDefault true;
      enableFormat = lib.mkDefault true;
    };
  };
}
