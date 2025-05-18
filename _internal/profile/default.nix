/*
This module provides a function to create profiles.
*/
{
  validation-tools,
  available-systems,
  common-tools,
}: let
  constants = import ./constants.nix;

  factory = import ./factory.nix {
    inherit validation-tools available-systems common-tools constants;
  };
in {
  inherit (factory) mkProfile;
}
