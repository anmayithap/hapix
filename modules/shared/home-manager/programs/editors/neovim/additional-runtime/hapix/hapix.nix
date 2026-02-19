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

    cfg = config.programs.nvf.settings.vim.runtimes.hapix-sched;
  in {
    options.programs.nvf.settings.vim.runtimes.hapix-sched.enable = lib.mkEnableOption "Hapix Scheduler";

    config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
      additionalRuntimePaths = lib.mkBefore [
        ./hapix-neovim
      ];

      luaConfigRC = {
        hapix-sched = entryBefore ["lazyConfigs"] ''
          require("hapix.sched").setup()
        '';
      };
    };
  };
}
