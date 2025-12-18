_: let
  DNS = [];

  networking = {lib, ...}: {
    networking = {
      knownNetworkServices = lib.mkBefore [
        "Wi-Fi"
        "Ethernet Adaptor"
      ];

      dns = lib.mkBefore DNS;
    };
  };
in {
  flake.modules.darwin = {inherit networking;};
}
