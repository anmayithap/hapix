# -----------------------------------------------------------------------------
# ## [PACKAGES -> nh]
# -----------------------------------------------------------------------------
#: Source: https://github.com/divnix/nh
#: Wrapper: https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/nh.html
#: Documentation: https://github.com/nix-community/nh/blob/master/docs/README.md
#: Changelog: https://github.com/nix-community/nh/blob/master/CHANGELOG.md
{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.nh = self.wrappers.nh.wrap {
      inherit pkgs;

      flake = "${inputs.hapix.outPath}";
    };
  };
}
