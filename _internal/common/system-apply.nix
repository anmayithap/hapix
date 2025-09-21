/*
This module defined custom function for applying attrs by system.
It includes function to apply attributes or fetch them by system name.

Functions:
1. pkgsForSystem: system -> pkgs
  Fetch all packages from Nixpkgs for given system.
*/
{lib}: let
  pkgsForSystem = {
    system,
    source,
  }:
    import source {
      inherit system;

      config.allowUnfree = true; # Set allowUnfree by default.
    };
in {
  inherit pkgsForSystem;
}
