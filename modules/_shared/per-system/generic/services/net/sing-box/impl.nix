# ----------------------------------------------------------------------------
# ## Generic Module: [Services > sing-box]
# Implementation
# ----------------------------------------------------------------------------
{
  flake.modules.generic.sing-box = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.services.sing-box;
  in {
    config = lib.mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        sing-box
      ];

      launchd.daemons = lib.mkIf pkgs.stdenv.isDarwin (
        lib.mkMerge (
          lib.mapAttrsToList (
            name: profile: {
              "sing-box-${name}" = lib.mkIf profile.enable {
                serviceConfig = {
                  ProgramArguments = ["${pkgs.sing-box}/bin/sing-box" "run" "-c" "${profile.configFile}"];
                  RunAtLoad = true;
                  KeepAlive = true;
                  StandardErrorPath = "/var/log/sing-box-${name}.log";
                  StandardOutPath = "/var/log/sing-box-${name}.log";
                };
              };
            }
          )
          cfg.profiles
        )
      );
    };
  };
}
