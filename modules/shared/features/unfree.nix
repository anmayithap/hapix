{inputs, ...}: {
  flake.modules.darwin.unfree = inputs.self.lib.nixpkgs-unfree;
  flake.modules.nixos.unfree = inputs.self.lib.nixpkgs-unfree;
}
