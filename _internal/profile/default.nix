/*
This module provides a function to create profiles.
*/
{
  haumea,
  common-tools,
}: let
  constants = haumea.lib.load {
    src = ./constants.nix;
  };

  factory = haumea.lib.load {
    src = ./factory.nix;
    inputs = {
      inherit constants common-tools;
    };
  };
in {
  inherit (factory) mkProfile;
}
