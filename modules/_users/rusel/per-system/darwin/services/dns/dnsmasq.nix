{
  flake.modules.darwin.rusel-dns = {
    lib,
    config,
    ...
  }: {
    services.dnsmasq = {
      servers = lib.mkBefore (
        map (socket: lib.strings.replaceString ":" "#" socket)
        config.services.dnscrypt-proxy.settings.listen_addresses
      );
    };
  };
}
