{
  flake.modules.darwin.rusel-dns = {
    lib,
    config,
    ...
  }: {
    services.dnscrypt-proxy = {
      settings = {
        query_log = {
          file = lib.mkForce "${config.users.users._dnscrypt-proxy.home}/query.log";
        };

        nx_log = {
          file = lib.mkForce "${config.users.users._dnscrypt-proxy.home}/nx.log";
        };

        sources = {
          public-resolvers = {
            cache_file = lib.mkForce "${config.users.users._dnscrypt-proxy.home}/public-resolvers.md";
          };
        };
      };
    };
  };
}
