#: ----------------------------------------------------------------------------
#: ## [WRAPPER -> fish] the user-friendly interactive shell
#: ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.fish` | `wrappers.fish`
#:
#: Module wrapper around the `fish` shell.
#:
#: Source: https://github.com/fish-shell/fish-shell
#: Documentation: https://fishshell.com/docs/current/index.html
#: Changelog: https://fishshell.com/docs/current/relnotes.html
#: Wrapper: https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/fish.html
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      fish = D true;
    };
  };

  flake.wrappers.fish = {wlib, ...}: {
    imports = [wlib.wrapperModules.fish];
  };
}
