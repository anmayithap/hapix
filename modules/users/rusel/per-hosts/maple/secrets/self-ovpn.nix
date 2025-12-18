{inputs, ...}: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    inherit (inputs) secrets;
  in {
    age = {
      secrets = {
        "maple.ovpn" = {
          file = "${secrets}/maple.ovpn.age";
          mode = "0600";
          path = "${homeDirectory}/openvpn/maple.ovpn";
          symlink = true;
        };
      };
    };
  };
}
