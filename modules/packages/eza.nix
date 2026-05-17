# -----------------------------------------------------------------------------
# ## [PACKAGES -> eza] modern replacement for ls
# -----------------------------------------------------------------------------
#: Source: https://github.com/eza-community/eza
#: Documentation: https://github.com/eza-community/eza#command-line-options
#: Changelog: https://github.com/eza-community/eza/blob/main/CHANGELOG.md
{self, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    B = lib.mkBefore;
  in {
    packages.eza = self.wrappers.eza.wrap {
      inherit pkgs;

      eza = {
        extraOptions = B [
          # ## View options
          "--width=100" # columns
          # ## Filtering options
          "--group-directories-first"
          "--sort=extension"
          # ## Long view options
          "--header"
          "--smart-group"
          "--binary"
          "--git"
          "--git-repos"
          "--time-style=long-iso"
        ];

        fzfOptions = B [
          "--all"
          "--color=always"
        ];
      };
    };
  };
}
