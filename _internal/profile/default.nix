/*
This module provides a function to create profiles.
*/
{common-tools}: let
  constants = import ./constants.nix;

  factory = import ./factory.nix {
    inherit constants common-tools;
  };
in {
  inherit (factory) mkProfile;
}
