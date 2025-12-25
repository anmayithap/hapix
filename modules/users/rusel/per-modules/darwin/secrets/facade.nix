{
  flake.modules.darwin.rusel = {config, ...}: {
    services.dnscrypt-proxy.settings.forwarding_rules = config.age.secrets."forwarding-rules".path;
  };
}
