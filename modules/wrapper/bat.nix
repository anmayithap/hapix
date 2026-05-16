#: ----------------------------------------------------------------------------
#: ## [WRAPPER -> bat] A cat(1) clone wrapper
#: ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.bat` | `wrappers.bat`
#:
#: Module wrapper around the `bat` utility for syntax highlighting.
#:
#: Source: https://github.com/sharkdp/bat
#: Changelog: https://github.com/sharkdp/bat/blob/master/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      bat = D true;
    };
  };

  flake.wrappers.bat = {
    wlib,
    lib,
    pkgs,
    config,
    ...
  }: let
    O = lib.mkOption;
    T = lib.types;
    D = lib.mkDefault;
  in {
    imports = [wlib.modules.default];

    options = {
      bat = O {
        type = T.submodule {
          options = {
            style = O {
              type = T.enum ["default" "full" "auto" "plain"];
              default = "default";
              defaultText = lib.literalExpression ''"default"'';
              example = lib.literalExpression ''"auto"'';
              description = ''
                The style of the `bat` output.

                By default, `bat` enables `changes`, `grid`, `header-filename`, `numbers` and `snip`.

                The available [`pre-defined`][url-id] styles are:

                - `default`: Enables the `recommended` style components listed above.
                - `full`:    Enables all available components.
                - `auto`:    Same as `default`, unless the output is piped.
                - `plain`:   Disables all available components.

                [url-id]: https://github.com/sharkdp/bat#output-style
              '';
            };
          };
        };
        default = {};
        defaultText = lib.literalExpression ''{}'';
        description = ''
          Submodule `bat`.

          Isolates `bat` options from the main `nix-wrapper-modules` options.
        '';
      };
    };

    config = {
      package = D pkgs.bat;

      flags."--style" = {
        data = config.bat.style;
        esc-fn = D config.escapingFunction;
      };
    };
  };
}
