{inputs, ...}: {
  flake.modules.nixos.nixos.imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    inputs.agenix.nixosModules.default

    inputs.self.modules.nixos.nix-settings
    inputs.self.modules.nixos.unfree
    inputs.self.modules.nixos.documentation
    inputs.self.modules.nixos.time
    inputs.self.modules.nixos.fonts
    inputs.self.modules.nixos.environment
    inputs.self.modules.darwin.system-packages
    inputs.self.modules.nixos.nix-index-database
    inputs.self.modules.nixos.agenix
  ];
}
