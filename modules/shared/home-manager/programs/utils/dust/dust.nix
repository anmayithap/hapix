# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > dust]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.dust = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.dust;
  in {
    options = {
      programs.dust = {
        enable = lib.mkEnableOption "dust";
        package = lib.mkPackageOption pkgs "dust" {};
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = [cfg.package];
    };
  };
}
