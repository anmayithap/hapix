{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) agenix;
in {
  environment.systemPackages = [
    agenix.packages."${pkgs.system}".default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];
}
