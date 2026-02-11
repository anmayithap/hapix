# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > tealdeer] shell aliases integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.tealdeer = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.tealdeer.enable;
  in {
    home.shellAliases = lib.mkIf predicate {
      tldr = "${lib.getExe config.programs.tealdeer.package}";
    };
  };
}
