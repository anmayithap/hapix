{inputs, ...}: let
  inherit (inputs) agenix;
in {
  imports = [
    agenix.darwinModules.default
  ];

  launchd.daemons."activate-agenix".serviceConfig = {
    StandardErrorPath = "/Library/Logs/org.nixos.activate-agenix.stderr.log";
    StandardOutPath = "/Library/Logs/org.nixos.activate-agenix.stdout.log";
  };
}
