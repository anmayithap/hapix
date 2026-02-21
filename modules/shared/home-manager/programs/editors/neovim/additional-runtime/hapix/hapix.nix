# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > Additional Runtime > Hapix]
# ------------------------------------------------------------------------------
# Provide additional configuration for nvf
{inputs, ...}: {
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    inherit (inputs.nvf.lib.nvim.dag) entryBefore;

    cfg = config.programs.nvf.settings.vim.runtimes;
  in {
    options.programs.nvf.settings.vim.runtimes = {
      enable = lib.mkEnableOption "Hapix Runtimes";

      hapix-sched.enable = lib.mkEnableOption "Hapix Scheduler";
      hapix-helper.enable = lib.mkEnableOption "Hapix Helper";
    };

    config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
      additionalRuntimePaths = lib.mkBefore [
        ./hapix-neovim
      ];

      luaConfigRC = {
        hapix-sched = lib.mkIf cfg.hapix-sched.enable (
          entryBefore ["lazyConfigs"] ''
            require("hapix.sched").setup()
          ''
        );
        hapix-helper = lib.mkIf cfg.hapix-helper.enable (
          entryBefore ["lazyConfigs"] ''
            require("hapix.helper").setup()
          ''
        );
      };
    };
  };
}
