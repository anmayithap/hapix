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

    custom.zsh.configFiles.".zshrc".fragments."zellij-aliases" = lib.mkIf zshEnabled {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => ZELLIJ ALIASES
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        alias zj='zellij'
      '';
      order = 905;
    };

    custom.zsh.configFiles.".zshrc".fragments."zellij-completions" = lib.mkIf zshEnabled {
      text = ''
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        # => ZELLIJ COMPLETIONS
        #""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        . <( zellij setup --generate-completion zsh | sed -Ee 's/^(_(zellij) ).*/compdef \1\2/' )
      '';
      order = 1008;
    };
  };
}
