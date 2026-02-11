# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > fastfetch] shell aliases integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fastfetch = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.fastfetch.enable;
  in {
    home.shellAliases = lib.mkIf predicate {
      ff = "${lib.getExe config.programs.fastfetch.package}";
    };
  };
}
