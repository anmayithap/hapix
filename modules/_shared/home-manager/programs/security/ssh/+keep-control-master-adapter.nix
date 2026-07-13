# ----------------------------------------------------------------------------
# ## Home Manager: [Programs > Security > ssh] Keep control master socket
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.ssh = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.ssh;
  in {
    home.file.".ssh/sockets/.keep".text = lib.mkIf cfg.enable "";
  };
}
