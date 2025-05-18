/*
This module contains custom function to provide simple way of working with paths.

Functions:
1. scanPaths: path -> [string] - returns list of files in given directory.
   If file name is default.nix, it will be included only if its extension is .nix.
*/
{nixpkgs}: let
  inherit (nixpkgs) lib;

  scanPaths = path:
    builtins.map
    (f: (path + "/${f}"))
    (builtins.attrNames
      (lib.attrsets.filterAttrs
        (
          path: _type:
            (_type == "directory") # include directories
            || (
              (path != "default.nix") # ignore default.nix
              && (lib.strings.hasSuffix ".nix" path) # include .nix files
            )
        )
        (builtins.readDir path)));
in {
  inherit scanPaths;
}
