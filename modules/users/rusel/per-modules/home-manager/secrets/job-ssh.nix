{inputs, ...}: {
  flake.modules.homeManager.rusel = {config, ...}: let
    inherit (config.user-meta) homeDirectory;
    inherit (inputs) secrets;
  in {
    age = {
      secrets = {
        "tat.ssh" = {
          file = "${secrets}/tat.ssh.age";
          mode = "0600";
          path = "${homeDirectory}/.ssh/tatitneft";
          symlink = true;
        };
        "tat.ssh.config" = {
          file = "${secrets}/tat.ssh.config.age";
          mode = "0600";
          path = "${homeDirectory}/.ssh/ssh_tatitneft_config";
          symlink = true;
        };
      };
    };
  };
}
