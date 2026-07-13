# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > zellij] fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zellij = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.fish.enable && config.programs.zellij.enable;
  in {
    programs.fish.shellAbbrs = lib.mkIf predicate {
      zj = "zellij";
    };
  };
}
