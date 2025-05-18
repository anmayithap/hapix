{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.fastfetch;
in {
  options.custom.fastfetch = {
    enable = lib.mkEnableOption "fastfetch custom configuration module";

    package = lib.mkPackageOption pkgs "fastfetch" {};
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
  };
}
