{
  flake.modules.generic.rusel-user = {
    lib,
    config,
    ...
  }: {
    users.users.${config.user-meta.username} = {
      name = lib.mkForce config.user-meta.username;
      description = lib.mkForce config.user-meta.fullname;
      home = config.user-meta.homeDirectory;
      createHome = lib.mkForce true;
      shell = lib.mkForce config.programs.fish.package;
    };
  };
}
