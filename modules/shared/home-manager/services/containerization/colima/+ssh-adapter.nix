# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization > colima] ssh adapter
# ----------------------------------------------------------------------------
# Include colima SSH config to global SSH
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
    programs.ssh.includes = lib.mkIf colimaCfg.enable (
      lib.mkAfter [
        "${colimaHome}/ssh_config"
      ]
    );
  };
}
