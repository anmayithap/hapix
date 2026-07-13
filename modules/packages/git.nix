#: ----------------------------------------------------------------------------
#: ## [PACKAGES -> git] free and open source distributed version control system
#: ----------------------------------------------------------------------------
#: Source: https://github.com/git/git
#: Documentation: https://git-scm.com/docs
#: Wrapper: https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/git.html
{self, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: let
    D = lib.mkDefault;
    B = lib.mkBefore;
  in {
    packages = {
      git = self.wrappers.git.wrap {
        inherit pkgs;

        settings = {
          #: Enable colors in color-supporting terminals
          color = {
            ui = D "auto";
          };
          init = {
            defaultBranch = D "master";
          };
          core = {
            #: Don't consider trailing space change as a cause for merge conflicts
            whitespace = B [
              "-trailing-space"
            ];
            eol = D "lf";
            autocrlf = D "input";
          };
          diff = {
            #: Use better, descriptive initials (c, i, w) instead of a/b
            mnemonicPrefix = D true;
            #: Show renames/moves as such
            renames = D true;
            #: When using --word-diff, assume --word-diff-regex=.
            wordRegex = D true;
            #: Display submodule-related information (commit listings)
            submodule = D true;
          };
          fetch = {
            #: Auto-fetch submodule changes (sadly, won't auto-update)
            recurseSubmodules = D "on-demand";
          };
          log = {
            #: Use abbrev SHAs whenever possible/relevant instead of full 40 chars
            abbrevCommit = D true;
            #: Automatically --follow when given a single path
            follow = D true;
            #: Disable decorate for reflog
            #: (because there is no dedicated `reflog` section available)
            decorate = D false;
          };
          merge = {
            #: Disable fast-forward merges as default merge strategy.
            #: Force explicit call of `git merge --ff …`.
            ff = D false;
            conflictStyle = D "zdiff3";
          };
          mergetool = {
            #: Clean up backup files created by merge tools on tool exit
            keepBackup = D false;
            #: Clean up temp files created by merge tools on tool exit
            keepTemporaries = D false;
            #: Put the temp files in a dedicated dir anyway
            writeToTemp = D true;
            #: Auto-accept file prompts when launching merge tools
            prompt = D false;
          };
          pull = {
            rebase = D "merges";
          };
          push = {
            default = D "upstream";
            autoSetupRemote = D true;
            followTags = D true;
          };
          status = {
            #: Display submodule rev change summaries in status
            submoduleSummary = D true;
            #: Recursively traverse untracked directories to display all contents
            showUntrackedFiles = D "all";
          };
          apply = {
            ignoreWhitespace = D true;
          };
          blame = {
            showEmail = D true;
          };
          checkout = {
            defaultRemote = D "origin";
          };
          commit = {
            gpgSign = D true;
          };
        };
      };
    };
  };
}
