# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization > colima] fish adapter
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.colima = {
    lib,
    config,
    ...
  }: let
    cfg = config.services.colima;
    predicate = config.programs.fish.enable && cfg.enable;
  in {
    programs.fish.shellAbbrs = lib.mkIf predicate {
      colima = {
        command = "colima";
        name = "start start --save-config=false";
      };
    };
  };
}
