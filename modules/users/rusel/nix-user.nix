{inputs, ...}: let
  user = {
    lib,
    config,
    ...
  }: let
    inherit (config.user-meta) username;
    inherit (config.user-meta) fullname;
    inherit (config.user-meta) homeDirectory;
  in {
    users.users.${username} = {
      name = lib.mkForce username;
      description = lib.mkForce fullname;
      home = homeDirectory;
      createHome = lib.mkForce true;
    };
  };
in {
  flake.modules.darwin.rusel.imports = [
    inputs.self.modules.darwin.user-meta

    user
  ];
}
