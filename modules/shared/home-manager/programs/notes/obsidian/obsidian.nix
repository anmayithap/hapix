# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Notes > obsidian]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.obsidian = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.obsidian;
  in {
    # ## Define package as unfree by default.
    unfree = [
      cfg.package
    ];

    programs.obsidian = {
      enable = lib.mkDefault false;
    };
  };
}
