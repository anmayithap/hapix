{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.zellij;

  yamlFormat = pkgs.formats.yaml {};

  zshEnabled = config.custom.zsh.enable;
in {
  options.custom.zellij = {
    enable = lib.mkEnableOption "zellij custom configuration module";

    package = lib.mkPackageOption pkgs "zellij" {};

    settings = lib.mkOption {
      inherit (yamlFormat) type;
      default = {};
    };

    attachExistingSession = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    exitShellOnExit = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    themes = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.oneOf [
          yamlFormat.type
          lib.types.path
          lib.types.lines
        ]
      );
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile = lib.mkMerge [
      {
        "zellij/zellij.yaml" =
          lib.mkIf (cfg.settings != {} && (lib.versionAtLeast cfg.package.version "0.32.0"))
          {
            source = yamlFormat.generate "zellij.yaml" cfg.settings;
          };
        "zellij/config.kdl" = lib.mkIf (cfg.settings != {} && (lib.versionAtLeast cfg.package.version "0.32.0")) {
          text = lib.hm.generators.toKDL {} cfg.settings;
        };
      }
      (lib.mapAttrs' (
          name: value:
            lib.nameValuePair "zellij/themes/${name}.kdl" {
              source =
                if builtins.isPath value || lib.isStorePath value
                then value
                else
                  pkgs.writeText "zellij-theme-${name}" (
                    if lib.isString value
                    then value
                    else lib.hm.generators.toKDL {} value
                  );
            }
        )
        cfg.themes)
    ];

    custom.zsh.configFiles = lib.mkIf zshEnabled {
      ".zshenv".fragments = {
        "zellij-env-variables" = {
          text = ''
            export ZELLIJ_AUTO_ATTACH=${
              if cfg.attachExistingSession
              then "true"
              else "false"
            }
            export ZELLIJ_AUTO_EXIT=${
              if cfg.exitShellOnExit
              then "true"
              else "false"
            }
          '';
          order = 101;
        };
      };
      ".zshrc".fragments = {
        "zellij-completions" = {
          text = ''
            # zellij completions (managed by custom/zellij module)

            eval "$(${lib.getExe cfg.package} setup --generate-auto-start zsh)"
          '';
          order = 1008;
        };
        "zellij-aliases" = lib.mkIf zshEnabled {
          text = ''
            #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
            # => ZELLIJ ALIASES
            #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

            alias zj='zellij'
          '';
          order = 905;
        };
      };
    };

    home.sessionVariables = lib.mkIf zshEnabled {
      ZELLIJ_AUTO_ATTACH =
        if cfg.attachExistingSession
        then "true"
        else "false";
      ZELLIJ_AUTO_EXIT =
        if cfg.exitShellOnExit
        then "true"
        else "false";
    };
  };
}
