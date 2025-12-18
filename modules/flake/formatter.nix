{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt.projectRootFile = lib.mkDefault "flake.nix";
  perSystem.treefmt.programs = {
    alejandra.enable = lib.mkDefault true;
    alejandra.excludes = lib.mkDefault [".direnv"];
    deadnix.enable = lib.mkDefault true;
    statix.enable = lib.mkDefault true;
  };
}
