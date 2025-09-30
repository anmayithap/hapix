{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) systems;
in {
  imports = [
    inputs.flake-parts.flakeModules.flakeModules
  ];

  debug = lib.mkForce true;

  systems = import systems;
}
