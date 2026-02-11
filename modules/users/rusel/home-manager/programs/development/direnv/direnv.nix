# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Development > direnv]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-direnv = {
    lib,
    config,
    ...
  }: {
    programs.direnv = {
      enable = lib.mkForce true;
      config = {
        whitelist = {
          prefix = [
            "${config.user-meta.homeDirectory}/dev"
            "${config.user-meta.homeDirectory}/learn"
            "${config.xdg.configHome}/hapix"
            "${config.xdg.configHome}/hapix-secret"
          ];
        };
      };
    };
  };
}
