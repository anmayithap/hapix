# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > Neovim > Additional Runtime > Hapix]
# ------------------------------------------------------------------------------
# Provide additional configuration for nvf
{
  flake.modules.homeManager.neovim = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.nvf.settings.vim.runtimes.hapix;
  in {
    options.programs.nvf.settings.vim.runtimes = lib.mkOption {
      type = lib.types.submodule {
        options = {
          hapix = lib.mkOption {
            type = lib.types.submodule {
              options = {
                enable = lib.mkEnableOption "Enable Hapix Runtime";
              };
            };
          };
        };
      };
    };

    config.programs.nvf.settings.vim = lib.mkIf cfg.enable {
      additionalRuntimePaths = lib.mkBefore [
        ./hapix-neovim
      ];

      luaConfigRC = {
        hapix = ''
          local hapix = require("hapix")
        '';
      };
    };
  };
}
