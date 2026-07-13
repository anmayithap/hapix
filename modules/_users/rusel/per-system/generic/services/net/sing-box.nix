{
  flake.modules.generic.rusel-net = {
    lib,
    config,
    ...
  }: {
    services.sing-box = {
      enable = lib.mkForce false;

      profiles = {
        default = {
          enable = lib.mkForce true;
          configFile = config.age.secrets.sing-box-default.path;
        };
      };
    };
  };
}
