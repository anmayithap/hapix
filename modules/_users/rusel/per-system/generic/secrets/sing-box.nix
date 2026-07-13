{inputs, ...}: {
  flake.modules.generic.rusel-secrets = {config, ...}: {
    age = {
      secrets = {
        sing-box-default = {
          file = "${inputs.secrets}/sing-box-default.age";
          mode = "a+rwx,u-wx,g-wx,o-wx";
          path = "${config.user-meta.homeDirectory}/.config/sing-box/default.json";
          symlink = true;
        };
      };
    };
  };
}
