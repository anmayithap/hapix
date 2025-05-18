{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (inputs) agenix secrets;
  inherit (config.home) homeDirectory;
  baseDirectory = homeDirectory + "/.agenix";
in
  assert agenix != null; {
    imports = [
      agenix.homeManagerModules.default
    ];

    age.secretsDir = baseDirectory + "/secrets";
    age.secretsMountPoint = baseDirectory + "/secrets.d";

    age.secrets = {
      ".netrc" = {
        file = "${secrets}/.netrc.age";
        mode = "0500";
        path = "${homeDirectory}/.netrc";
        symlink = true;
      };

      "maple.ovpn" = {
        file = "${secrets}/maple.ovpn.age";
        mode = "0600";
        path = "${config.xdg.configHome}/openvpn/maple.ovpn";
        symlink = true;
      };

      "tat.maple.ovpn" = {
        file = "${secrets}/tat.maple.ovpn.age";
        mode = "0600";
        path = "${config.xdg.configHome}/openvpn/tat.maple.ovpn";
        symlink = true;
      };

      ".env" = {
        file = "${secrets}/.env.age";
        mode = "0600";
        path = "${homeDirectory}/.env";
        symlink = true;
      };

      "rclone.conf" = lib.mkIf config.programs.rclone.enable {
        file = "${secrets}/rclone.conf.age";
        mode = "0600";
        path = "${config.xdg.configHome}/rclone/rclone.conf";
        symlink = true;
      };
    };
  }
