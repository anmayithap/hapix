#: ----------------------------------------------------------------------------
#: ## [WRAPPER -> fzf] a command-line fuzzy finder
#: ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.fzf` | `wrappers.fzf`
#:
#: Module wrapper around the `fzf` utility for fuzzy finding.
#:
#: Source: https://github.com/junegunn/fzf
#: Documentation: https://junegunn.github.io/fzf/
#: Changelog: https://github.com/junegunn/fzf/blob/master/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      fzf = D true;
    };
  };

  flake.wrappers.fzf = {
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
  in {
    imports = [wlib.modules.default];

    options = {
      fzf = O {
        type = T.submodule {
          options = {
            defaultOptions = O {
              type = T.listOf T.str;
              default = [];
              defaultText = lib.literalExpression ''[]'';
              example = lib.literalExpression ''
                [
                  "--height=40%"
                  "--border"
                ]
              '';
              description = ''
                Extra `fzf` command line options given by default.
              '';
            };
          };
        };
        default = {};
        defaultText = lib.literalExpression ''{}'';
        description = ''
          Submodule `fzf`.

          Isolates `fzf` options from the main `nix-wrapper-modules` options.
        '';
      };
    };

    config = {
      package = D pkgs.fzf;

      env = {
        FZF_DEFAULT_OPTS = If (config.fzf.defaultOptions != []) {
          data = lib.concatStringsSep " " config.fzf.defaultOptions;
          esc-fn = config.escapingFunction;
        };
      };
    };
  };
}
