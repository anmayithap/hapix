# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization > colima] zsh adapter
# ----------------------------------------------------------------------------
# Add zsh completion for colima
{
  flake.modules.homeManager.colima = {
    lib,
    pkgs,
    config,
    ...
  }: let
    colimaCfg = config.services.colima;

    mkAfterCompInit = lib.mkOrder 600;

    colimaExe = lib.getExe pkgs.colima;
  in {
    programs.zsh = {
      initContent =
        lib.mkIf colimaCfg.enable
        (
          mkAfterCompInit ''
            eval "$(${colimaExe} completion zsh)"
          ''
        );
    };
  };
}
