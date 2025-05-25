/*
This module provides orchestra for creating various NixOS configurations.
It offers a way to create configurations that are tailored to specific
environments or systems, such as 'nix-darwin' or 'home-manager' modules.

Functions:
1. mkConfigurations: {profiles} -> attrset
  Creates configurations for 'nix-darwin' and 'home-manager' systems.
*/
{
  inputs,
  profile-tools,
  common-tools,
  validation-tools,
  factory-tools,
}: let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;

  mkConfiguration = {
    pkgs,
    stable-pkgs,
    profile,
  }: let
    isDarwin = common-tools.isDarwinBySystemName profile.system;
    isLinux = common-tools.isLinuxBySystemName profile.system;

    specialArgs = {
      inherit profile pkgs stable-pkgs inputs common-tools validation-tools;
    };
  in {
    darwinSystem =
      if isDarwin
      then
        factory-tools.mkDarwin {
          inherit profile specialArgs;

          darwin-modules = [
            ../../apps-patch.nix
            ../../modules/darwin
          ];

          home-modules = [
            ../../apps-patch.nix
            ../../home/darwin
            ../../custom
            ../../hosts/${profile.username}-${profile.hostname}/home.nix
          ];
        }
      else null;

    nixosSystem =
      if isLinux
      then {}
      else null;
  };

  mkConfigurations = {profiles}: let
    processedProfiles = lib.map (profileData: profile-tools.mkProfile profileData) profiles;

    allConfigurations = lib.listToAttrs (
      lib.map (profile: {
        name = profile.hostname;
        value = mkConfiguration {
          inherit profile;
          pkgs = common-tools.pkgsForSystem {
            inherit (profile) system;
            source = inputs.nixpkgs;
          };
          stable-pkgs = common-tools.stablePkgsForSystem {
            inherit (profile) system;
            source = inputs.nixpkgs-stable;
          };
        };
      })
      processedProfiles
    );

    extractSystemType = systemTypeName: let
      filteredConfigurations =
        lib.filterAttrs
        (hostname: hostConfig: hostConfig.${systemTypeName} != null)
        allConfigurations;
    in
      lib.mapAttrs
      (hostname: hostConfig: hostConfig.${systemTypeName})
      filteredConfigurations;
  in {
    nixosConfigurations = extractSystemType "nixosSystem";
    darwinConfigurations = extractSystemType "darwinSystem";
  };
in {
  inherit mkConfigurations;
}
