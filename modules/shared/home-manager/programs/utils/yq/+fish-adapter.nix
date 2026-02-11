# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > yq] fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.yq = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.fish.enable && config.programs.yq.enable;
  in {
    programs.fish.shellAbbrs = lib.mkIf predicate {
      jq = "yq";
    };
  };
}
