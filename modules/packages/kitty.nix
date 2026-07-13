#: ----------------------------------------------------------------------------
#: ## [PACKAGES -> kitty] The fast, feature-rich, GPU based terminal emulator
#: ----------------------------------------------------------------------------
#: Source: https://github.com/kovidgoyal/kitty
#: Documentation: https://sw.kovidgoyal.net/kitty/
#: Wrapper: https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/kitty.html
#: Changelog: https://sw.kovidgoyal.net/kitty/changelog/
{self, ...}: {
  perSystem = {pkgs, ...}: {
    packages.kitty = self.wrappers.kitty.wrap {
      inherit pkgs;
    };
  };
}
