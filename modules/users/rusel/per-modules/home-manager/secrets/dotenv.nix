{inputs, ...}: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    inherit (inputs) secrets;
  in {
    age = {
      secrets = {
        ".env" = {
          file = "${secrets}/.env.age";
          mode = "0600";
          path = "${homeDirectory}/.env";
          symlink = true;
        };
      };
    };
  };
}
