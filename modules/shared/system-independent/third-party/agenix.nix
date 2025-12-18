_: let
  agenix = {
    age = {
      identityPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };
  };
in {
  flake.modules.darwin = {inherit agenix;};
  flake.modules.nixos = {inherit agenix;};
}
