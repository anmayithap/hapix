# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization > colima] docker adapter
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.colima = {
    lib,
    pkgs,
    config,
    ...
  }: let
    jsonFormat = pkgs.formats.json {};

    cfg = config.services.colima;
    dockerCfg = config.programs.docker-cli;
  in {
    home.file = lib.mkIf (dockerCfg.enable && cfg.enable) {
      "${dockerCfg.configDir}/daemon.json" = {
        source = jsonFormat.generate "daemon.json" cfg.profiles.default.settings.docker;
        force = true;
      };
    };
  };
}
