# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > p7zip]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.p7zip = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.p7zip;
  in {
    options = {
      programs.p7zip = {
        enable = lib.mkEnableOption "p7zip.";
        package = lib.mkPackageOption pkgs "p7zip" {};
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = [cfg.package];
    };
  };
}
