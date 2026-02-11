# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization > docker] variables adapter
# ----------------------------------------------------------------------------
# Add session variables for docker
{
  flake.modules.homeManager.docker = {
    lib,
    config,
    ...
  }: let
    xdgCfg = config.xdg;
    homeCfg = config.home;

    dockerCfg = config.programs.docker-cli;

    dockerHome =
      if xdgCfg.enable
      then "${xdgCfg.configHome}/docker"
      else "${homeCfg.homeDirectory}/.docker";

    mkFancyForce = lib.mkOverride 51;
  in {
    home.sessionVariables = lib.mkIf dockerCfg.enable {
      DOCKER_CONFIG = mkFancyForce dockerHome;
    };
  };
}
