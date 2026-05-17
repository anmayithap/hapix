#: ----------------------------------------------------------------------------
#: ## [WRAPPER -> starship] cross-shell prompt
#: ----------------------------------------------------------------------------
#:
#: ### `wrapperModules.starship` | `wrappers.starship`
#:
#: Module wrapper around the `starship` utility for cross-shell prompts.
#:
#: Source: https://github.com/starship/starship
#: Documentation: https://starship.rs/config/
#: Changelog: https://github.com/starship/starship/blob/main/CHANGELOG.md
{
  perSystem = {lib, ...}: let
    D = lib.mkDefault;
  in {
    wrappers.packages = {
      #: Exclude being built into `packages.*.*` flake output
      starship = D true;
    };
  };

  flake.wrappers.starship = {
    wlib,
    lib,
    ...
  }: let
    #: `Passthru` function to enable starship prompt integration in shell
    withShell = self: shell: let
      bin = lib.getExe self;
    in
      if shell == "fish"
      then ''
        # Enable ${shell} starship prompt integration
        if test "$TERM" != "dumb"
          ${bin} init ${shell} | source
        end
      ''
      else throw "shell ${shell} is not supported yet";
  in {
    imports = [wlib.wrapperModules.starship];

    passthru = {
      inherit withShell;
    };
  };
}
