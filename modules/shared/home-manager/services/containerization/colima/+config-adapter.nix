# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization > colima] config adapter
# ----------------------------------------------------------------------------
# Move colima configuration files to $COLIMA_HOME
{
  flake.modules.homeManager.colima = {
    lib,
    pkgs,
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

    yamlFormat = pkgs.formats.yaml {};
  in {
    home.file = lib.mkIf colimaCfg.enable (
      lib.mkMerge (
        lib.mapAttrsToList (profileName: profile: {
          "${colimaHome}/_templates/${profileName}.yaml" = {
            source = yamlFormat.generate "${profileName}.yaml" profile.settings;
          };
          ".colima/${profileName}/colima.yaml" = {
            enable = lib.mkForce false;
          };
        }) (lib.filterAttrs (_name: profile: profile.settings != {}) colimaCfg.profiles)
      )
    );
  };
}
