/*
This module provides factories for creating various NixOS configurations.
It offers a way to create configurations that are tailored to specific
environments or systems, such as 'nix-darwin' or 'home-manager' modules.

Functions:
1. mkDarwin: {profile, specialArgs, darwin-modules, home-modules} -> nix-darwin.lib.darwinSystem
  Creates a NixOS configuration for 'nix-darwin' systems.
*/
{inputs}: let
  inherit (inputs) nix-darwin home-manager;

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
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "home-manager.backup";

            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users."${profile.username}".imports = home-modules;
          }
        ];
    };
in {
  inherit mkDarwin;
}
