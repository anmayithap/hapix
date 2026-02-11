# ----------------------------------------------------------------------------
# ## Home Manager Module: Configures user preset.
# The configuration is based on the `user-meta` module, so it must be imported.
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.user = {
    lib,
    config,
    ...
  }: let
    cfg = config.user-meta;
  in {
    home = {
      username = lib.mkForce cfg.username;
      homeDirectory = lib.mkForce cfg.homeDirectory;
    };
  };
}
