{inputs, ...}: let
  unfree = inputs.self.lib.nixpkgs-unfree;
in {
  flake.modules.homeManager.rusel.imports = [
    unfree
  ];
}
