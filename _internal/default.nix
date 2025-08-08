/*
This module provides internal tools for the NixOS configuration.
*/
{
  self,
  inputs,
  available-systems ? ["aarch64-linux" "x86_64-linux"],
}: let
  # Extract lib from unstable nixpkgs.
  inherit (inputs.nixpkgs) lib;
  # Extract haumea filesystem-based module.
  inherit (inputs) haumea;

  # Evaluate validation tools.
  validation-tools = haumea.lib.load {
    src = ./validators.nix;
    inputs = {
      inherit lib;
    };
  };

  # Evaluate common configuration tools.
  common-tools = haumea.lib.load {
    src = ./common;
    inputs = {
      inherit lib;
      inherit haumea;
    };
  };

  # Evaluate profile configurations tools.
  profile-tools = haumea.lib.load {
    src = ./profile;
    inputs = {
      inherit lib;
      inherit haumea;
    };
  };

  # Evaluate configuration tools.
  configuration-tools = haumea.lib.load {
    src = ./configuration;
    inputs = {
      inherit self;
      inherit lib;
      inherit haumea;
      inherit inputs;
      inherit profile-tools;
      inherit common-tools;
      inherit validation-tools;
      inherit available-systems;
    };
  };
in {
  inherit common-tools validation-tools profile-tools configuration-tools;
}
