# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization > colima] variables adapter
# ----------------------------------------------------------------------------
# Add session variables for colima
{
  flake.modules.homeManager.colima = {
    lib,
    config,
    ...
  }: let
    colimaCfg = config.services.colima;

    xdgCfg = config.xdg;
    homeCfg = config.home;

    colimaHome =
      if xdgCfg.enable
      then "${xdgCfg.configHome}/colima"
      else "${homeCfg.homeDirectory}/.colima";
  in {
    home.sessionVariables = lib.mkIf colimaCfg.enable {
      COLIMA_HOME = "${colimaHome}";
      DOCKER_HOST = "unix://${colimaHome}/default/docker.sock";
    };
  };
}
