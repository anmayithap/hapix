/*
This module provides factories for creating various NixOS configurations.
It offers a way to create configurations that are tailored to specific
environments or systems, such as 'nix-darwin' or 'home-manager' modules.

Functions:
1. mkDarwin: {profile, specialArgs, darwin-modules, home-modules} -> nix-darwin.lib.darwinSystem
  Creates a NixOS configuration for 'nix-darwin' systems.
2. mkLinux: {profile, specialArgs, linux-modules, home-modules} -> nixpkgs.lib.nixosSystem
  Creates a NixOS configuration for Linux systems.
*/
{inputs}: let
  mkDarwin = {
    inputs,
    lib,
    profile,
    common-tools,
    validation-tools,
    genSpecialArgs,
    darwin-modules,
    home-modules ? [],
    specialArgs ? (genSpecialArgs profile.system),
  }: let
    inherit (inputs) nixpkgs-darwin home-manager nix-darwin;
  in nix-darwin.lib.darwinSystem {
      inherit (profile) system;
      inherit specialArgs;

      modules =
        darwin-modules
        ++ [
          (
            { lib, ... }:
            {
              nixpkgs.pkgs = common-tools.pkgsForSystem {
                inherit (profile) system;
                source = nixpkgs-darwin;
              };
            }
          )
        ]
        ++ (lib.optionals ((lib.lists.length home-modules) > 0) [
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "home-manager.backup";
              extraSpecialArgs = specialArgs;
              users."${profile.username}".imports = home-modules;
            };
          }
        ]);
    };

  mkLinux = {
    inputs,
    lib,
    profile,
    common-tools,
    validation-tools,
    genSpecialArgs,
    linux-modules,
    home-modules ? [],
    specialArgs ? (genSpecialArgs profile.system),
  }: let
    inherit (inputs) nixpkgs home-manager;
  in
    nixpkgs.lib.nixosSystem {
      inherit (profile) system;
      inherit specialArgs;

  modules =
    linux-modules
    ++ (lib.optionals ((lib.lists.length home-modules) > 0) [
      home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "home-manager.backup";
              extraSpecialArgs = specialArgs;
              users."${profile.username}".imports = home-modules;
            };
          }
    ]);
    };
in {
  inherit mkDarwin mkLinux;
}
