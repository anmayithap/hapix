{inputs, ...}: {
  flake.modules.nixos.wsl = {
    imports = [
      inputs.nixos-wsl.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-index-database.nixosModules.nix-index
      inputs.agenix.nixosModules.default

      inputs.self.modules.nixos.nix-settings
      inputs.self.modules.nixos.unfree
      inputs.self.modules.nixos.time
      inputs.self.modules.nixos.fonts
      inputs.self.modules.darwin.system-packages
      inputs.self.modules.nixos.nix-index-database
      inputs.self.modules.nixos.agenix
      inputs.self.modules.nixos.wsl
    ];
  };
}
