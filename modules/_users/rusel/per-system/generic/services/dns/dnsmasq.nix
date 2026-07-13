{
  flake.modules.generic.rusel-dns = {lib, ...}: {
    services.dnsmasq = {
      enable = lib.mkDefault true;
    };
  };
}
