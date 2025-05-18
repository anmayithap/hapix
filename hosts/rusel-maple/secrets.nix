{
  config,
  inputs,
  ...
}: let
  inherit (config.home) homeDirectory;
  inherit (inputs) secrets;
in {
  age.identityPaths = [
    "${homeDirectory}/.ssh/id_ed25519"
  ];

  age.secrets = {
    "ssh_maple" = {
      file = "${secrets}/ssh_maple.age";
      mode = "0600";
      path = "${homeDirectory}/.ssh/maple";
      symlink = true;
    };
    "ssh_tatitneft" = {
      file = "${secrets}/ssh_tatitneft.age";
      mode = "0600";
      path = "${homeDirectory}/.ssh/tatitneft";
      symlink = true;
    };
  };
}
