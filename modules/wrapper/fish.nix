# -----------------------------------------------------------------------------
# ## [WRAPPER -> fish] the user-friendly interactive shell
# -----------------------------------------------------------------------------
#: Source: https://github.com/fish-shell/fish-shell
#: Documentation: https://fishshell.com/docs/current/index.html
#: Changelog: https://fishshell.com/docs/current/relnotes.html
#: Wrapper: https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/fish.html
{
  perSystem = {lib, ...}: {
    wrappers.packages = {
      fish = lib.mkDefault true; # ## Exclude being built into `packages.*.*` flake output
    };
  };

  flake.wrappers.fish = {wlib, ...}: {
    imports = [wlib.wrapperModules.fish];
  };
}
