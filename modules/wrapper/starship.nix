# -----------------------------------------------------------------------------
# ## [WRAPPER -> starship] cross-shell prompt
# -----------------------------------------------------------------------------
#: Source: https://github.com/starship/starship
#: Documentation: https://starship.rs/config/
#: Changelog: https://github.com/starship/starship/blob/main/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      starship = D true; # ## Exclude being built into `packages.*.*` flake output
    };
  };

  flake.wrappers.starship = {
    wlib,
    lib,
    ...
  }: {
    imports = [wlib.wrapperModules.starship];

    passthru = {
      withShell = self: shell: let
        bin = lib.getExe self;
      in
        if shell == "fish"
        then "${bin} init ${shell} | source"
        else if shell == "bash" || shell == "zsh"
        then "eval \"$(${bin} init ${shell})\""
        else throw;
    };
  };
}
