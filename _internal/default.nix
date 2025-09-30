/*
This module provides internal tools for the NixOS configuration.
*/
{
  inputs,
  available-systems ? ["aarch64-linux" "x86_64-linux"],
}: let
  # Extract lib from unstable nixpkgs.
  inherit (inputs.nixpkgs) lib;

  # Evaluate validation tools.
  validation-tools = import ./validators.nix {
    inherit lib inputs available-systems;
  };

  # Evaluate common configuration tools.
  common-tools = import ./common {
    inherit lib inputs available-systems;
  };

  # Evaluate profile configurations tools.
  profile-tools = import ./profile {
    inherit common-tools;
  };

  # Evaluate configuration tools.
  configuration-tools = import ./configuration {
    inherit lib;
    inherit inputs;
    inherit profile-tools;
    inherit common-tools;
    inherit validation-tools;
    inherit available-systems;
  };
in {
  inherit common-tools validation-tools profile-tools configuration-tools;
}
