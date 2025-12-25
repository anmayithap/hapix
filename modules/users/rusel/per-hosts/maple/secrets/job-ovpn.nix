{inputs, ...}: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    inherit (inputs) secrets;
  in {
    age = {
      secrets = {
        "tat.ovpn" = {
          file = "${secrets}/tat.ovpn.age";
          mode = "0600";
          path = "${homeDirectory}/vpn/ovpn/tat.ovpn";
          symlink = true;
        };
        "tat.ovpn.auth" = {
          file = "${secrets}/tat.ovpn.auth.age";
          mode = "0600";
          path = "${homeDirectory}/vpn/ovpn/tat.ovpn.auth.txt";
          symlink = true;
        };
      };
    };
  };
}
