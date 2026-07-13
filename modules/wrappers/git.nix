#: ----------------------------------------------------------------------------
#: ## [WRAPPER -> git] free and open source distributed version control system
#: ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.git` | `wrappers.git`
#:
#: Module wrapper around the `git` utility for git integration.
#:
#: Source: https://github.com/git/git
#: Documentation: https://git-scm.com/docs
#: Wrapper: https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/git.html
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      git = D true;
    };
  };

  flake.wrappers.git = {wlib, ...}: {
    imports = [wlib.wrapperModules.git];
  };
}
