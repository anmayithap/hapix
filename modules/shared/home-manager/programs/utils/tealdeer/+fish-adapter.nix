# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > tealdeer] fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.tealdeer = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.fish.enable && config.programs.tealdeer.enable;
  in {
    programs.fish.shellAbbrs = lib.mkIf predicate {
      tldr = "tealdeer";
    };
  };
}
