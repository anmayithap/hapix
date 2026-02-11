# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > duf] shell aliases integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.duf = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.duf.enable;
  in {
    home.shellAliases = lib.mkIf predicate {
      df = "${lib.getExe config.programs.duf.package}";
    };
  };
}
