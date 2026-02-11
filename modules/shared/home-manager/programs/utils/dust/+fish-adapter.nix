# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > dust] fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.dust = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.dust.enable;
  in {
    programs.fish.shellAbbrs = lib.mkIf predicate {
      du = "dust";
    };
  };
}
