{inputs, ...}: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    inherit (inputs) secrets;
  in {
    age = {
      secrets = {
        "tat.maple.ovpn" = {
          file = "${secrets}/tat.maple.ovpn.age";
          mode = "0600";
          path = "${homeDirectory}/openvpn/tat.maple.ovpn";
          symlink = true;
        };
      };
    };
  };
}
