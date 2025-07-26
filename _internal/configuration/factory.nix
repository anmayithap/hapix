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
  inherit (inputs) nixpkgs nix-darwin home-manager;

  mkDarwin = {
    profile,
    specialArgs,
    darwin-modules,
    home-modules,
  }:
    nix-darwin.lib.darwinSystem {
      inherit (profile) system;
      inherit specialArgs;

      modules =
        darwin-modules
        ++ [
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
        ];
    };

  mkLinux = {
    profile,
    specialArgs,
    linux-modules,
    home-modules,
  }:
    nixpkgs.lib.nixosSystem {
      inherit (profile) system;
      inherit specialArgs;
    };
in {
  inherit mkDarwin mkLinux;
}
