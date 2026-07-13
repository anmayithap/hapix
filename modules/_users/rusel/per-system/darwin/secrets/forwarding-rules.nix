{inputs, ...}: {
  flake.modules.darwin.rusel-secrets = {config, ...}: {
    age = {
      secrets = {
        forwarding-rules = {
          file = "${inputs.secrets}/forwarding-rules.age";
          mode = "a+rwx,u-wx,g-wx,o-wx";
          path = "${config.users.users._dnscrypt-proxy.home}/forwarding-rules.txt";
          symlink = true;
        };
      };
    };
  };
}
