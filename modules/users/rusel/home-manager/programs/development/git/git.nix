# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Development > git]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-git = {
    lib,
    config,
    ...
  }: {
    programs.git = {
      enable = lib.mkForce true;

      settings = {
        user = {
          name = lib.mkForce config.user-meta.fullname;
          email = lib.mkForce config.user-meta.email;
        };
      };
    };
  };
}
