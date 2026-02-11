# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > duf]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.duf = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.duf;
  in {
    options = {
      programs.duf = {
        enable = lib.mkEnableOption "duf";
        package = lib.mkPackageOption pkgs "duf" {};
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = [cfg.package];
    };
  };
}
