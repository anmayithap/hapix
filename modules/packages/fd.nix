# -----------------------------------------------------------------------------
# ## [PACKAGES -> fd] a simple, fast and user-friendly alternative to find
# -----------------------------------------------------------------------------
#: Source: https://github.com/sharkdp/fd
#: Documentation: https://github.com/sharkdp/fd#how-to-use
#: Changelog: https://github.com/sharkdp/fd/blob/master/CHANGELOG.md
{self, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    D = lib.mkDefault;
  in {
    packages.fd = self.wrappers.fd.wrap {
      inherit pkgs;

      fd = {
        hidden = D true;
      };
    };
  };
}
