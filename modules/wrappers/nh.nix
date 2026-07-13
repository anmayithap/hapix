#: ---------------------------------------------------------------------------
#: ## [WRAPPER -> nh]
#: ---------------------------------------------------------------------------
#:
#: ### `wrapperModules.nh` | `wrappers.nh`
#:
#: Module wrapper around the `nh` utility for managing nix-shell environments.
#:
#: Source: https://github.com/divnix/nh
#: Wrapper: https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/nh.html
#: Documentation: https://github.com/nix-community/nh/blob/master/docs/README.md
#: Changelog: https://github.com/nix-community/nh/blob/master/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      nh = D true;
    };
  };

  flake.wrappers.nh = {wlib, ...}: {
    imports = [wlib.wrapperModules.nh];
  };
}
