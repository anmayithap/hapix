{
  flake.modules.darwin.rusel-dns = {
    lib,
    config,
    ...
  }: {
    networking.dns = lib.mkAfter [
      config.services.dnsmasq.bind
    ];

    launchd.daemons = {
      dnscrypt-proxy = {
        serviceConfig = {
          StandardOutPath = lib.mkForce "${config.users.users._dnscrypt-proxy.home}/stdout.log";
          StandardErrorPath = lib.mkForce "${config.users.users._dnscrypt-proxy.home}/stderr.log";
        };
      };
    };
  };
}
