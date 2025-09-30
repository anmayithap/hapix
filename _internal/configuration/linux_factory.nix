{
  lib,
  inputs,
  profile,
  common-tools,
  linux-modules,
  home-modules ? [],
  system,
  genSpecialArgs,
  specialArgs ? (genSpecialArgs system),
  ...
} @ args: let
  inherit (inputs) nixpkgs home-manager;
in
  nixpkgs.lib.nixosSystem {
    inherit system specialArgs;
    modules =
      nixos-modules
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
