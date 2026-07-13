#: ----------------------------------------------------------------------------
#: ## [PACKAGES -> write-npins] write-npins
#: ----------------------------------------------------------------------------
#: This package is necessary for the automatic generation of npins `source.json`,
#: unfortunately a bug has been discovered at the moment, a temporary solution
#: is presented here.
#: See: https://github.com/vic/flake-file/issues/103
{
  perSystem = {
    pkgs,
    config,
    ...
  }: let
    #: Overriding the derivation to use the absolute path to GNU `mktemp`
    fix = config.packages.write-npins.overrideAttrs (_: previous: {
      text =
        builtins.replaceStrings
        ["mktemp"]
        ["${pkgs.coreutils}/bin/mktemp"]
        previous.text;
      runtimeInputs = (previous.runtimeInputs or []) ++ [pkgs.coreutils];
    });
  in {
    packages.write-npins-fixed = fix;
  };
}
