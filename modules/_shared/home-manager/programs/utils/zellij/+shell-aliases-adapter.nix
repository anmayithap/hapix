# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > zellij] shell aliases integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.zellij = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.zellij.enable;
  in {
    home.shellAliases = lib.mkIf predicate {
      zj = "${lib.getExe config.programs.zellij.package}";
    };
  };
}
