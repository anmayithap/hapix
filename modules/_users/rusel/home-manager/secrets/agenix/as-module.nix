# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Secrets > Agenix]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-agenix = {
    lib,
    config,
    ...
  }: {
    age = {
      identityPaths = lib.mkBefore [
        "${config.user-meta.homeDirectory}/.ssh/id_ed25519"
      ];
    };
  };
}
