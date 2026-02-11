# ----------------------------------------------------------------------------
# ## Home Manager Module: [XDG]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.xdg = {
    lib,
    config,
    ...
  }: let
    cfg = config.xdg;
  in {
    xdg.enable = lib.mkDefault false;

    home.preferXdgDirectories = cfg.enable;
  };
}
