#: ----------------------------------------------------------------------------
#: ## [PACKAGES -> fzf] a command-line fuzzy finder
#: ----------------------------------------------------------------------------
#: Source: https://github.com/junegunn/fzf
#: Documentation: https://junegunn.github.io/fzf/
#: Changelog: https://github.com/junegunn/fzf/blob/master/CHANGELOG.md
{self, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    B = lib.mkBefore;
  in {
    packages.fzf = self.wrappers.fzf.wrap {
      inherit pkgs;

      fzf = {
        defaultOptions = B [
          ''--style=\"full\"''
          ''--height=\"~40%\"''
          ''--border=\"bold\"''
          ''--layout=\"reverse\"''
          ''--preview-window=\"border-bold\"''
          ''--padding=\"1\"''
          ''--margin=\"1\"''
          ''--prompt=\"> \"''
          ''--marker=\">\"''
          ''--pointer=\"+\"''
          ''--separator=\"_\"''
          ''--scrollbar=\"|\"''
          ''--info=\"right\"''

          ''--bind=\"ctrl-/:toggle-preview\"'' # ## Toggle preview by pressing `ctrl-/`
          ''--bind=\"alt-j:preview-down\"'' # ## Scroll preview down by pressing `alt-j`
          ''--bind=\"alt-k:preview-up\"'' # ## Scroll preview up by pressing `alt-k`
        ];
      };
    };
  };
}
