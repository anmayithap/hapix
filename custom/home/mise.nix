{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.mise;

  tomlFormat = pkgs.formats.toml {};

  zshEnabled = config.custom.zsh.enable;
in {
  options.custom.mise = {
    enable = lib.mkEnableOption "mise custom configuration module";

    package = lib.mkPackageOption pkgs "mise" {nullable = true;};

    globalConfig = lib.mkOption {
      inherit (tomlFormat) type;
      default = {};
    };

    settings = lib.mkOption {
      inherit (tomlFormat) type;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf (cfg.package != null) [cfg.package];

    xdg.configFile = {
      "mise/config.toml" = lib.mkIf (cfg.globalConfig != {}) {
        source = tomlFormat.generate "mise-config" cfg.globalConfig;
      };
      "mise/settings.toml" = lib.mkIf (cfg.settings != {}) {
        source = tomlFormat.generate "mise-settings" cfg.settings;
      };
    };

    custom.zsh.configFiles.".zshrc".fragments."mise-hooks" = lib.mkIf zshEnabled {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => MISE HOOKS
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        eval "$(${lib.getExe cfg.package} activate zsh --shims)"
      '';
      order = 1009;
    };
  };
}
