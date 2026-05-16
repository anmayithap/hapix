#: ----------------------------------------------------------------------------
#: ## [WRAPPER -> typos] source code spell checker
#: ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.typos` | `wrappers.typos`
#:
#: Module wrapper around the `typos` utility for checking
#: the correctness of the source code for errors in spelling words.
#:
#: Source: https://github.com/crate-ci/typos
#: Documentation: https://github.com/crate-ci/typos/blob/master/docs/reference.md
#: Changelog: https://github.com/crate-ci/typos/blob/master/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      typos = D true;
    };
  };

  flake.wrappers.typos = {
    lib,
    wlib,
    pkgs,
    config,
    ...
  }: let
    O = lib.mkOption;
    D = lib.mkDefault;
    T = lib.types;

    tomlFormat = pkgs.formats.toml {};
  in {
    imports = [wlib.modules.default];

    options = {
      typos = O {
        type = T.submodule {
          options = {
            configFileName = O {
              type = T.enum ["typos.toml" "_typos.toml" ".typos.toml"];
              default = ".typos.toml";
              defaultText = lib.literalExpression ''".typos.toml"'';
              example = lib.literalExpression ''"_typos.toml"'';
              description = ''
                The name of the `typos` configuration file to
                generate in the wrapper's file tree. This file is passed to the
                `--config` flag.

                See the upstream documentation on [configuration file discovery](https://github.com/crate-ci/typos/blob/master/docs/reference.md#sources)
                for details on supported file names.
              '';
            };
            settings = O {
              inherit (tomlFormat) type;
              default = {};
              defaultText = lib.literalExpression ''{}'';
              example = lib.literalExpression ''
                {
                  default.extend-ignore-re = [ "^[a-f0-9]{40}$" ];
                  files.extend-exclude = [ "CHANGELOG.md" ];
                  type.cpp.extend-glob = [ "hpp" ];
                }
              '';
              description = ''
                Structured configuration for `typos`, serialized to TOML and written to
                {option}`configFileName`.

                Refer to the [upstream reference](https://github.com/crate-ci/typos/blob/master/docs/reference.md#typos-reference)
                for available options and their semantics.
              '';
            };
          };
        };
        default = {};
        defaultText = lib.literalExpression ''{}'';
        description = ''
          Submodule `typos`.

          Isolates `typos` options from the main `nix-wrapper-modules` options.
        '';
      };
    };

    config = {
      package = D pkgs.typos;

      flags = {
        "--config" = {
          data = config.constructFiles.generatedConfig.path;
        };
      };

      constructFiles = {
        generatedConfig = {
          content = D (builtins.toJSON config.typos.settings);
          relPath = D config.typos.configFileName;
          builder = D ''
            mkdir -p "$(dirname "$2")" && ${pkgs.remarshal}/bin/json2toml "$1" "$2"
          '';
        };
      };

      passthru = {
        inherit (config.constructFiles) generatedConfig;
      };
    };
  };
}
