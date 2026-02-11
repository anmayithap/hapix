{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.utility.oil-nvim.gitStatus = {
      enable = lib.mkDefault true;

      setupOpts = {
        win_options = {
          signcolumn = lib.mkDefault "yes:2";
        };
      };
    };
  };
}
