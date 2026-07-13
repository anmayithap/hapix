# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization > docker] zsh adapter
# ----------------------------------------------------------------------------
# Add zsh completion for docker
{
  flake.modules.homeManager.docker = {
    lib,
    pkgs,
    config,
    ...
  }: let
    dockerCfg = config.programs.docker-cli;

    mkAfterCompInit = lib.mkOrder 600;

    dockerExe = lib.getExe pkgs.docker;
  in {
    programs.zsh = {
      initContent = lib.mkIf dockerCfg.enable (
        mkAfterCompInit ''
          eval "$(${dockerExe} completion zsh)"
        ''
      );
    };
  };
}
