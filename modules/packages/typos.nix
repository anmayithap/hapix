#: ----------------------------------------------------------------------------
#: ## [PACKAGES -> typos] source code spell checker
#: ----------------------------------------------------------------------------
#: Source: https://github.com/crate-ci/typos
#: Documentation: https://github.com/crate-ci/typos/blob/master/docs/reference.md
#: Changelog: https://github.com/crate-ci/typos/blob/master/CHANGELOG.md
{self, ...}: {
  perSystem = {pkgs, ...}: {
    #: Specific implementation of `typos` for `hapix`.
    #: Used for linting or formatting `hapix` configuration.
    packages.hapix-typos = self.wrappers.typos.wrap {
      inherit pkgs;

      typos = {
        settings = {
          default = {
            extend-ignore-re = [
              ''.*(?:#|--|//|/*).*(?:spellchecker|typos):\\s?ignore[^\\n]*\\n"''
              ''.*(?:spellchecker|typos):\\s?ignore-next-line[^\\n]*\\n[^\\n]*''
            ];
          };
        };
      };
    };
  };
}
