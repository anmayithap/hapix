# ----------------------------------------------------------------------------
# ## [PACKAGES -> commitizen] release management tool
# ----------------------------------------------------------------------------
#: Source: https://github.com/commitizen-tools/commitizen
#: Documentation: https://commitizen-tools.github.io/commitizen
#: Changelog: https://github.com/commitizen-tools/commitizen/blob/master/CHANGELOG.md
{self, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    D = lib.mkDefault;
  in {
    packages.hapix-commitizen = self.wrappers.commitizen.wrap {
      inherit pkgs;

      commitizen = {
        settings = {
          name = D "cz_conventional_commits";
          use_shortcuts = D true;
          tag_format = D "v$version";
          version_provider = D "scm";
          version_scheme = D "semver2";
        };
      };
    };
  };
}
