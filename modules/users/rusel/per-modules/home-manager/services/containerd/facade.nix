{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    pkgs,
    ...
  }: let
    cfg = config.services.colima;
    colimaHome = "${config.xdg.configHome}/colima";
    yamlFormat = pkgs.formats.yaml {};
  in {
    home.file = lib.mkMerge (
      lib.mapAttrsToList (profileName: profile: {
        "${colimaHome}/_templates/${profileName}.yaml" = {
          source = yamlFormat.generate "${profileName}.yaml" profile.settings;
        };
        ".colima/${profileName}/colima.yaml" = {
          enable = lib.mkForce false;
        };
      }) (lib.filterAttrs (_name: profile: profile.settings != {}) cfg.profiles)
    );

    programs.ssh.includes = lib.mkAfter [
      "${colimaHome}/ssh_config"
    ];

    home.sessionVariables = {
      COLIMA_HOME = "${colimaHome}";
      DOCKER_HOST = "unix://${colimaHome}/default/docker.sock";
    };

    programs.zsh = with pkgs; {
      initContent = lib.mkOrder 1000 ''
        eval "$(${lib.getExe colima} completion zsh)"
        eval "$(${lib.getExe docker} completion zsh)"
      '';
    };
  };
}
