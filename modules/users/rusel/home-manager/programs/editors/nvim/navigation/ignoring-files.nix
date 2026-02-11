{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.globals = {
      ignoring_files = lib.mkBefore [
        ".DS_Store"
      ];
    };
  };
}
