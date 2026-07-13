# ----------------------------------------------------------------------------
# ## [WRAPPER -> commitizen] release management tool
# ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.commitizen` | `wrappers.commitizen`
#:
#: Module wrapper around the `commitizen` utility for release management.
#:
#: Source: https://github.com/commitizen-tools/commitizen
#: Documentation: https://commitizen-tools.github.io/commitizen
#: Changelog: https://github.com/commitizen-tools/commitizen/blob/master/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      commitizen = D true;
    };
  };

  flake.wrappers.commitizen = {
    lib,
    wlib,
    pkgs,
    config,
    ...
  }: let
    O = lib.mkOption;
    T = lib.types;
    D = lib.mkDefault;

    tomlFormat = pkgs.formats.toml {};
    #: Minimum configuration for commitizen to work
  in {
    imports = [wlib.modules.default];

    options = {
      commitizen = O {
        type = T.submodule {
          options = {
            configFileName = O {
              type = T.enum [".cz.toml" "cz.toml"];
              default = ".cz.toml";
              defaultText = lib.literalExpression ''".cz.toml"'';
              example = lib.literalExpression ''"cz.toml"'';
              description = ''
                The name of the `commitizen` configuration file to
                generate in the wrapper's file tree. This file is passed to the
                `--config` flag.

                See the upstream documentation on [configuration file discovery](https://commitizen-tools.github.io/commitizen/config/configuration_file/)
                for details on supported file names.
              '';
            };
            settings = O {
              inherit (tomlFormat) type;
              default = {};
              defaultText = lib.literalExpression ''{}'';
              example = lib.literalExpression ''
                {
                  name = "cz_conventional_commits";
                  use_shortcuts = true;
                  tag_format = "v$version";
                  version_provider = "scm";
                  version_scheme = "semver2";
                }
              '';
              description = ''
                Structured configuration for `commitizen`, serialized to TOML and written to
                {option}`configFileName`.

                Refer to the [upstream reference](https://commitizen-tools.github.io/commitizen/config/option/)
                for available options and their semantics.
              '';
            };
          };
        };
        default = {};
        defaultText = lib.literalExpression ''{}'';
        description = ''
          Submodule `commitizen`.

          Isolates `commitizen` options from the main `nix-wrapper-modules` options.
        '';
      };
    };

    config = {
      package = D pkgs.commitizen;

      flags = {
        "--config" = {
          data = D config.constructFiles.generatedConfig.path;
        };
      };

      constructFiles.generatedConfig = {
        content = D (builtins.toJSON config.commitizen.settings);
        relPath = D config.commitizen.configFileName;
        builder = D ''mkdir -p "$(dirname "$2")" && ${pkgs.remarshal}/bin/json2toml "$1" "$2"'';
      };

      passthru = {
        inherit (config.constructFiles) generatedConfig;
      };
    };
  };
}
