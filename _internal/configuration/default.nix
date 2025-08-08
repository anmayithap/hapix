/*
This module offers utilities for managing various NixOS configurations,
including but not limited to 'nix-darwin', 'nixos', and 'home-manager' modules.
It provides a flexible framework to streamline the configuration process across
different environments and systems.
*/
{
  lib,
  inputs,
  profile-tools,
  common-tools,
  validation-tools,
  available-systems,
}: let
  processProfiles = profiles: lib.map (profileData: profile-tools.mkProfile profileData) profiles;

  mkConfiguration = profile: let
    inherit (profile) system;

    genSpecialArgs = system: inputs // {
      inherit profile common-tools validation-tools;

      pkgs-unstable = common-tools.pkgsForSystem {
        inherit system;
        source = inputs.nixpkgs-unstable;
      };

      pkgs-stable = common-tools.pkgsForSystem {
        inherit system;
        source = inputs.nixpkgs-stable;
      };
    };

    args = {
      inherit inputs lib profile common-tools validation-tools genSpecialArgs;
    };
  in assert validation-tools.validate (lib.elem system available-systems) "System '${system}' is not supported. Available: ${lib.concatStringsSep ", " available-systems}"; {
  };

  mkConfigurations = profiles: let
    processedProfiles = processProfiles profiles;

    processedConfigurations = lib.map (profile: mkConfiguration profile) processedProfiles;
  in {
    inherit processedConfigurations;
  };
in {
  inherit mkConfigurations;
}
