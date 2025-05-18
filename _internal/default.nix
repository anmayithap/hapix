/*
This module provides internal tools for the NixOS configuration.
*/
{
  inputs,
  available-systems ? ["aarch64-linux" "x86_64-linux"],
}: let
  validation-tools = import ./validators.nix {
    inherit (inputs) nixpkgs;
  };

  common-tools = import ./common {
    inherit (inputs) nixpkgs;
    inherit available-systems;
  };

  profile-tools = import ./profile {
    inherit available-systems common-tools validation-tools;
  };

  configuration-tools = import ./configuration {
    inherit inputs common-tools profile-tools validation-tools;
  };
in {
  inherit common-tools validation-tools profile-tools configuration-tools;
}
