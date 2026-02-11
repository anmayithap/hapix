{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.keymaps = lib.mkAfter [
      {
        key = "-";
        mode = ["n"];
        action = ":Oil<CR>";
        silent = true;
        desc = "Open parent directory";
      }
    ];
  };
}
