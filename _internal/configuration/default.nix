/*
This module offers utilities for managing various NixOS configurations,
including but not limited to 'nix-darwin', 'nixos', and 'home-manager' modules.
It provides a flexible framework to streamline the configuration process across
different environments and systems.
*/
{
  inputs,
  common-tools,
  profile-tools,
  validation-tools,
}: let
  factory-tools = import ./factory.nix {
    inherit inputs;
  };

  configuration-tools = import ./orchestra.nix {
    inherit inputs common-tools profile-tools factory-tools validation-tools;
  };
in {
  inherit (configuration-tools) mkConfigurations;
}
