/*
This module defined custom function for applying attrs by system.
It includes function to apply attributes or fetch them by system name.

Functions:
1. pkgsForSystem: system -> pkgs
  Fetch all packages from Nixpkgs for given system.
2. forAllSystems: (system, pkgs) -> attrs
  Apply function on each system and return result as attribute set.
*/
{
  nixpkgs,
  available-systems,
}: let
  pkgsForSystem = {
    system,
    source,
  }:
    import source {
      inherit system;

      config.allowUnfree = true; # Set allowUnfree by default.
    };

  forAllSystems = f:
    nixpkgs.lib.genAttrs available-systems (
      system:
        f system nixpkgs.legacyPackages.${system}
    );
in {
  inherit pkgsForSystem forAllSystems;
}
