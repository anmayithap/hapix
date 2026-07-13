# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Secrets > Agenix] SSH integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-agenix = {
    lib,
    config,
    ...
  }: {
    programs.ssh = {
      includes = lib.mkAfter [
        config.age.secrets."tat.ssh.config".path
      ];
    };
  };
}
