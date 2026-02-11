# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > yq] shell aliases integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.yq = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.yq.enable;
  in {
    home.shellAliases = lib.mkIf predicate {
      jq = "${lib.getExe config.programs.yq.package}";
    };
  };
}
