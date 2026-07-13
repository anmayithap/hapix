#: ----------------------------------------------------------------------------
#: ## [PACKAGES -> bat] A wrapped cat(1) clone
#: ----------------------------------------------------------------------------
#: Source: https://github.com/sharkdp/bat
#: Changelog: https://github.com/sharkdp/bat/blob/master/CHANGELOG.md
{self, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    D = lib.mkDefault;
  in {
    packages.bat = self.wrappers.bat.wrap {
      inherit pkgs;

      bat = {
        style = D "auto";
      };
    };
  };
}
