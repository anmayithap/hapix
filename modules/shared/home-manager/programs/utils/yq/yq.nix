# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > yq]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.yq = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.yq;
  in {
    options = {
      programs.yq = {
        enable = lib.mkEnableOption "yq";
        package = lib.mkPackageOption pkgs "yq" {};
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = [cfg.package];
    };
  };
}
