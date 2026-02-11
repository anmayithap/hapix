# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Development > uv] zsh integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.uv = {
    lib,
    config,
    pkgs,
    ...
  }: let
    predicate = config.programs.uv.enable && config.programs.zsh.enable;

    mkInitExtra = lib.mkOrder 1000;
  in {
    programs.zsh.initContent = lib.mkIf predicate (
      mkInitExtra ''
        eval "$(${pkgs.uv}/bin/uv generate-shell-completion zsh)"
        eval "$(${pkgs.uv}/bin/uvx --generate-shell-completion zsh)"
      ''
    );
  };
}
