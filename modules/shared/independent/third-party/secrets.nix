_: let
  secrets = {
    age = {
      identityPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };
  };
in {
  flake.modules.darwin = {inherit secrets;};
  flake.modules.nixos = {inherit secrets;};
}
