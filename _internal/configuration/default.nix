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

    systemCheck = validation-tools.validate (lib.elem system available-systems) "System '${system}' is not supported. Available: ${lib.concatStringsSep ", " available-systems}";

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
  in assert systemCheck; {
    systemConfiguration = {${system} = import ./${system} (args // {inherit system;});};
  };

  mkConfigurations = profiles: let
    processedProfiles = processProfiles profiles;

    processedConfigurations = lib.map (profile: mkConfiguration profile) processedProfiles;

    allSystemsCombined = lib.foldl' (acc: config: acc // config.systemConfiguration) {} processedConfigurations;

    nixosSystems = lib.filterAttrs (systemName: _: common-tools.isLinuxBySystemName systemName) allSystemsCombined;
    darwinSystems = lib.filterAttrs (systemName: _: common-tools.isDarwinBySystemName systemName) allSystemsCombined;

    allSystems = nixosSystems // darwinSystems;
    allSystemNames = builtins.attrNames allSystems;
    nixosSystemValues = builtins.attrValues nixosSystems;
    darwinSystemValues = builtins.attrValues darwinSystems;
    allSystemValues = nixosSystemValues ++ darwinSystemValues;
  in {
    debugAttrs = {
      inherit
        nixosSystems
        darwinSystems
        allSystems
        allSystemNames
        ;
    };

    nixosConfigurations = lib.attrsets.mergeAttrsList (
      map (it: it.nixosConfigurations or { }) nixosSystemValues
    );

    darwinConfigurations = lib.attrsets.mergeAttrsList (
      map (it: it.darwinConfigurations or { }) darwinSystemValues
    );

    packages = forAllSystems (system: allSystems.${system}.packages or { });
  };
in {
  inherit mkConfigurations;
}
