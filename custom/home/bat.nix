{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.bat;
in {
  options.custom.bat = {
    enable = lib.mkEnableOption "bat custom configuration module";

    package = lib.mkPackageOption pkgs "bat" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
  };
}
