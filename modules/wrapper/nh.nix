# ----------------------------------------------------------------------------
# ## [WRAPPER -> nh]
# ----------------------------------------------------------------------------
#: Source: https://github.com/divnix/nh
#: Wrapper: https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/nh.html
#: Documentation: https://github.com/nix-community/nh/blob/master/docs/README.md
#: Changelog: https://github.com/nix-community/nh/blob/master/CHANGELOG.md
{
  perSystem = {lib, ...}: {
    wrappers.packages = {
      nh = lib.mkDefault true; # ## Exclude being built into `packages.*.*` flake output
    };
  };

  flake.wrappers.nh = {wlib, ...}: {
    imports = [wlib.wrapperModules.nh];
  };
}
