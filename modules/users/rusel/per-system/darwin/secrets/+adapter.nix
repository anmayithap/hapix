{
  flake.modules.darwin.rusel-dns = {config, ...}: {
    services.dnscrypt-proxy = {
      settings = {
        forwarding_rules = config.age.secrets."forwarding-rules".path;
      };
    };
  };
}
