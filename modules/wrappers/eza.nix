#: ----------------------------------------------------------------------------
#: ## [WRAPPER -> eza] modern replacement for ls
#: ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.eza` | `wrappers.eza`
#:
#: Module wrapper around the `eza` utility for listing files and directories.
#:
#: Source: https://github.com/eza-community/eza
#: Documentation: https://github.com/eza-community/eza#command-line-options
#: Changelog: https://github.com/eza-community/eza/blob/main/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      eza = D true;
    };
  };

  flake.wrappers.eza = {
    wlib,
    lib,
    pkgs,
    config,
    ...
  }: let
    O = lib.mkOption;
    T = lib.types;
    D = lib.mkDefault;
    B = lib.mkBefore;
  in {
    imports = [wlib.modules.default];

    options = {
      eza = O {
        type = T.submodule {
          options = {
            colors = O {
              type = T.enum ["auto" "always" "never"];
              default = "auto";
              defaultText = lib.literalExpression ''"auto"'';
              example = lib.literalExpression ''"always"'';
              description = ''
                When to use terminal colors.

                See [display options reference](https://github.com/eza-community/eza#display-options)
              '';
            };
            icons = O {
              type = T.enum ["auto" "always" "never"];
              default = "auto";
              defaultText = lib.literalExpression ''"auto"'';
              example = lib.literalExpression ''"always"'';
              description = ''
                When to display icons.

                See [display options reference](https://github.com/eza-community/eza#display-options)
              '';
            };
            extraOptions = O {
              type = T.listOf T.str;
              default = [];
              defaultText = lib.literalExpression ''[]'';
              example = lib.literalExpression ''
                [
                  "--width=100"
                ]
              '';
              description = ''
                Extra options to pass to `eza`.

                See [command line options reference](https://github.com/eza-community/eza#command-line-options)
              '';
            };
            fzfOptions = O {
              type = T.listOf T.str;
              default = [];
              defaultText = lib.literalExpression ''[]'';
              example = lib.literalExpression ''
                [
                  "--all"
                  "--color=always"
                ]
              '';
              description = ''
                `fzf`-specific options.

                ::: {.note}
                These options are not included in the wrapper.
                :::

                Passed via {option}`passthru` for use on the command line.
              '';
            };
          };
        };
        default = {};
        defaultText = lib.literalExpression ''{}'';
        description = ''
          Submodule `eza`.

          Isolates `eza` options from the main `nix-wrapper-modules` options.
        '';
      };
    };

    config = {
      package = D pkgs.eza;

      flags = {
        "--color" = {
          data = D config.eza.colors;
          esc-fn = D config.escapingFunction;
          sep = D "=";
          before = ["WRAPPED_EZA_EXTRA_OPTIONS"];
        };
        "--icons" = {
          data = D config.eza.icons;
          esc-fn = D config.escapingFunction;
          sep = D "=";
          before = ["WRAPPED_EZA_EXTRA_OPTIONS"];
        };
      };

      appendFlag = [
        {
          name = "WRAPPED_EZA_EXTRA_OPTIONS";
          data = B config.eza.extraOptions;
          esc-fn = D config.escapingFunction;
        }
      ];

      passthru = {
        fzfOptions = lib.concatStringsSep " " config.eza.fzfOptions;
      };
    };
  };
}
