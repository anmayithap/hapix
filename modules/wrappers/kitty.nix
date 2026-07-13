#: ----------------------------------------------------------------------------
#: ## [WRAPPER -> kitty] The fast, feature-rich, GPU based terminal emulator
#: ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.kitty` | `wrappers.kitty`
#:
#: Module wrapper around the `kitty` terminal emulator.
#:
#: Source: https://github.com/kovidgoyal/kitty
#: Documentation: https://sw.kovidgoyal.net/kitty/
#: Wrapper: https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/kitty.html
#: Changelog: https://sw.kovidgoyal.net/kitty/changelog/
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      kitty = D true;
    };
  };

  flake.wrappers.kitty = {wlib, ...}: {
    imports = [wlib.wrapperModules.kitty];
  };
}
