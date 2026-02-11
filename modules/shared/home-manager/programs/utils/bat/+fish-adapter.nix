# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > bat] fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.bat = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.bat.enable && config.programs.fish.enable;
  in {
    programs.fish = lib.mkIf predicate {
      shellAbbrs = {
        # ## Highlighting `--help` messages with bat
        "--help '--help | bat -plhelp'" = {
          position = "anywhere";
        };
        "-h '-h | bat -plhelp'" = {
          position = "anywhere";
        };
        # ## Abbreviation for `cat` command
        "cat" = "bat --paging=never";
      };
    };
  };
}
