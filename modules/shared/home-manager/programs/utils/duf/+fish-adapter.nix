# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > duf] fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.duf = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.duf.enable;
  in {
    programs.fish.shellAbbrs = lib.mkIf predicate {
      df = "duf";
    };
  };
}
