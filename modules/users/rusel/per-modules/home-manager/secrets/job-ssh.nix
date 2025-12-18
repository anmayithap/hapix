{inputs, ...}: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    inherit (inputs) secrets;
  in {
    age = {
      secrets = {
        "ssh_tatitneft" = {
          file = "${secrets}/ssh_tatitneft.age";
          mode = "0600";
          path = "${homeDirectory}/.ssh/tatitneft";
          symlink = true;
        };
      };
    };
  };
}
