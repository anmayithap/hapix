{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf.settings.vim.fzf-lua = {
      enable = lib.mkDefault true;
      profile = lib.mkDefault "fzf-native";

      setupOpts = {
        ui_select = lib.mkDefault true;
        color_icons = lib.mkDefault true;
        cwd = lib.mkDefault true;
        cwd_only = lib.mkDefault true;
        file_icons = lib.mkDefault true;
        formatter = lib.mkDefault "path.filename_first";
        git_icons = lib.mkDefault true;
        multiprocess = lib.mkDefault true;
      };
    };
  };
}
