{inputs, ...}: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    inherit (inputs) secrets;
  in {
    age = {
      secrets = {
        "maple.ssh" = {
          file = "${secrets}/maple.ssh.age";
          mode = "0600";
          path = "${homeDirectory}/.ssh/maple";
          symlink = true;
        };
      };
    };
  };
}
