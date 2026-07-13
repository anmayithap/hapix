#: ----------------------------------------------------------------------------
#: ## [WRAPPER -> fd] a simple, fast and user-friendly alternative to find
#: ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.fd` | `wrappers.fd`
#:
#: Module wrapper around the `fd` utility for finding files and directories.
#:
#: Source: https://github.com/sharkdp/fd
#: Documentation: https://github.com/sharkdp/fd#how-to-use
#: Changelog: https://github.com/sharkdp/fd/blob/master/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      fd = D true;
    };
  };

  flake.wrappers.fd = {
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
    If = lib.mkIf;
  in {
    imports = [wlib.modules.default];

    options = {
      fd = O {
        type = T.submodule {
          options = {
            hidden = O {
              type = T.bool;
              default = false;
              defaultText = lib.literalExpression ''false'';
              example = lib.literalExpression ''true'';
              description = ''
                Search hidden files and directories.

                Passed by `--hidden` flag.
              '';
            };
            extraOptions = O {
              type = T.listOf T.str;
              default = [];
              defaultText = lib.literalExpression ''[]'';
              example = lib.literalExpression ''
                [
                  "--type f"
                ]
              '';
              description = ''
                Extra options to pass to `fd`.

                See [reference](https://github.com/sharkdp/fd#how-to-use)
              '';
            };
            fzfOptions = O {
              type = T.listOf T.str;
              default = [];
              defaultText = lib.literalExpression ''[]'';
              example = lib.literalExpression ''
                [
                  "--hidden"
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
          Submodule `fd`.

          Isolates `fd` options from the main `nix-wrapper-modules` options.
        '';
      };
    };

    config = {
      package = D pkgs.fd;

      appendFlag = B [
        (
          If config.fd.hidden {
            data = "--hidden";
            esc-fn = D config.escapingFunction;
          }
        )
        {
          data = B config.fd.extraOptions;
          esc-fn = D config.escapingFunction;
        }
      ];

      passthru = {
        fzfOptions = lib.concatStringsSep " " config.fd.fzfOptions;
      };
    };
  };
}
