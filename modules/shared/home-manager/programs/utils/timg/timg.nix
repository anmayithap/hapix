# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > timg]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.timg = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.timg;
  in {
    options = {
      programs.timg = {
        enable = lib.mkEnableOption "timg. Terminal image and video viewer.";
        package = lib.mkPackageOption pkgs "timg" {};
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = [cfg.package];
    };
  };
}
