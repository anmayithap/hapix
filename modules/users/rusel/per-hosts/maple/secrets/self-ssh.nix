{inputs, ...}: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    inherit (inputs) secrets;
  in {
    age = {
      secrets = {
        "ssh_maple" = {
          file = "${secrets}/ssh_maple.age";
          mode = "0600";
          path = "${homeDirectory}/.ssh/maple";
          symlink = true;
        };
      };
    };
  };
}
