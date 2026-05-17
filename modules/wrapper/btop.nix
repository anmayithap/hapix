#: ----------------------------------------------------------------------------
#: ## [WRAPPER -> btop] A monitor of resources
#: ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.btop` | `wrappers.btop`
#:
#: Module wrapper around the `btop` utility for monitoring system resources.
#:
#: Source: https://github.com/aristocratos/btop
#: Documentation: https://github.com/aristocratos/btop#configurability
#: Changelog: https://github.com/aristocratos/btop/blob/main/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      btop = D true;
    };
  };

  flake.wrappers.btop = {
    wlib,
    lib,
    pkgs,
    config,
    ...
  }: let
    O = lib.mkOption;
    T = lib.types;
    D = lib.mkDefault;
    If = lib.mkIf;

    keyValueFormat = pkgs.formats.keyValue {};
  in {
    imports = [wlib.wrapperModules.btop];

    options = {
      btop = O {
        type = T.submodule {
          options = {
            settings = O {
              inherit (keyValueFormat) type;
              default = {};
              defaultText = lib.literalExpression ''{}'';
              example = lib.literalExpression ''
                {
                  color_theme = "ayu"
                }
              '';
              description = ''
                Structured configuration for `btop`

                Refer to the [upstream reference](https://github.com/aristocratos/btop#configurability)
                for available options and their semantics.
              '';
            };
          };
        };
        default = {};
        defaultText = lib.literalExpression ''{}'';
        description = ''
          Submodule `btop`.

          Isolates `btop` options from the main `nix-wrapper-modules` options.
        '';
      };
    };

    config = {
      package = pkgs.btop;

      flags = {
        "--config" = If (config.btop.settings != {}) {
          data = config.constructFiles.generatedConfig.path;
        };
      };

      constructFiles = {
        generatedConfig = If (config.btop.settings != {}) {
          content = D (lib.generators.toKeyValue {} config.btop.settings);
          relPath = D "btop.conf";
        };
      };

      passthru = {
        inherit (config.constructFiles) generatedConfig;
      };
    };
  };
}
