# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization > docker]
# ----------------------------------------------------------------------------
# Home Manager: `https://nix-community.github.io/home-manager/options.xhtml#opt-programs.docker-cli.enable`
# Derivation: `https://github.com/nix-community/home-manager/blob/master/modules/programs/docker-cli.nix`
{
  flake.modules.homeManager.docker = {
    lib,
    pkgs,
    config,
    ...
  }: let
    dockerCfg = config.programs.docker-cli;
  in {
    home.packages = lib.mkIf dockerCfg.enable (
      with pkgs; [
        docker
      ]
    );

    programs.docker-cli = {
      enable = lib.mkDefault false;
    };
  };
}
