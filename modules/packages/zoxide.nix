# -----------------------------------------------------------------------------
# ## [PACKAGES -> zoxide] a smarter cd command
# -----------------------------------------------------------------------------
#: Source: https://github.com/ajeetdsouza/zoxide
#: Documentation: https://github.com/ajeetdsouza/zoxide#configuration
#: Changelog: https://github.com/ajeetdsouza/zoxide/blob/main/CHANGELOG.md
{self, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    D = lib.mkDefault;
    A = lib.mkAfter;
  in {
    packages.zoxide = self.wrappers.zoxide.wrap {
      inherit pkgs;

      zoxide = {
        echo = D true;
        excludeDirs = A [
          "$HOME"
          "/tmp"
          "/var"
          "/nix"
        ];
        maxAge = D 10000;
        resolveSymlinks = D true;
      };
    };
  };
}
