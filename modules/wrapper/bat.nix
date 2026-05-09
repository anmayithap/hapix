# -----------------------------------------------------------------------------
# ## [WRAPPER -> bat] A cat(1) clone wrapper
# -----------------------------------------------------------------------------
#: Source: https://github.com/sharkdp/bat
#: Changelog: https://github.com/sharkdp/bat/blob/master/CHANGELOG.md
{
  perSystem = {
    wrappers.packages = {
      bat = true; # ## Exclude being built into `packages.*.*` flake output
    };
  };

  flake.wrappers.bat = {
    wlib,
    lib,
    pkgs,
    config,
    ...
  }: let
    D = lib.mkDefault;
    O = lib.mkOption;
  in {
    imports = [wlib.modules.default];

    options = {
      bat = O {
        type = lib.types.submodule {
          options = {
            style = O {
              type = lib.types.enum ["default" "full" "auto" "plain"];
              default = "default";
              defaultText = "default";
              description = ''
                The style of the `bat` output.

                By default, `bat` enables `changes`, `grid`, `header-filename`, `numbers` and `snip`.

                The available pre-defined styles are:

                - `default`: Enables the recommended style components listed above.
                - `full`: Enables all available components.
                - `auto`: Same as `default`, unless the output is piped.
                - `plain`: Disables all available components.

                See: https://github.com/sharkdp/bat#output-style
              '';
              example = lib.literalExpression "auto";
            };
          };
        };
        default = {};
        description = ''
          Specialized configuration module for `bat`.
        '';
      };
    };

    config = {
      package = D pkgs.bat;

      flags."--style" = {
        data = config.bat.style;
        esc-fn = toString;
      };
    };
  };
}
