{
  lib,
  inputs,
  profile,
  common-tools,
  darwin-modules,
  home-modules ? [],
  system,
  genSpecialArgs,
  specialArgs ? (genSpecialArgs system),
  ...
} @ args: let
  inherit (inputs) nixpkgs-darwin home-manager nix-darwin;
in
  nix-darwin.lib.darwinSystem {
    inherit system specialArgs;
    modules =
      darwin-modules
      ++ [
        (
          {lib, ...}: {
            nixpkgs.pkgs = common-tools.pkgsForSystem {
              inherit system;
              source = inputs.nixpkgs-unstable;
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
  }
