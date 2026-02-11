# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > dust] shell aliases integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.dust = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.dust.enable;
  in {
    home.shellAliases = lib.mkIf predicate {
      du = "${lib.getExe config.programs.dust.package}";
    };
  };
}
