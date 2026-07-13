#: ----------------------------------------------------------------------------
#: ## [PACKAGES -> starship] cross-shell prompt
#: ----------------------------------------------------------------------------
#: Source: https://github.com/starship/starship
#: Documentation: https://starship.rs/config/
#: Changelog: https://github.com/starship/starship/blob/main/CHANGELOG.md
{self, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    B = lib.mkBefore;
  in {
    packages.starship = self.wrappers.starship.wrap {
      inherit pkgs;

      preset = B [
        "nerd-font-symbols"
      ];
    };
  };
}
