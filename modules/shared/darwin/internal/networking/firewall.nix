_: let
  networking = {lib, ...}: {
    networking.applicationFirewall = {
      enable = lib.mkDefault true;
    };
  };
in {
  flake.modules.darwin = {inherit networking;};
}
