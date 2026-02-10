# ----------------------------------------------------------------------------
# ## Maple Host Module: Configures known users.
# List of users owned and managed by nix-darwin.
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.maple = {
    lib,
    config,
    ...
  }: {
    users.knownUsers = lib.mkBefore [
      config.users.users.rusel.name
    ];
  };
}
