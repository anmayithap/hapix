{inputs, ...}: {
  flake.modules.nixos.wsl = {
    imports = [
      inputs.nixos-wsl.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-index-database.nixosModules.nix-index
      inputs.agenix.nixosModules.default

      inputs.self.modules.nixos.documentation
      inputs.self.modules.nixos.environment
      inputs.self.modules.nixos.fonts
      inputs.self.modules.nixos.nix-settings
      inputs.self.modules.nixos.time

      inputs.self.modules.nixos.nix-index-database
      inputs.self.modules.nixos.secrets

      inputs.self.modules.nixos.system-programs
      inputs.self.modules.nixos.editor-programs
      inputs.self.modules.nixos.language-programs
      inputs.self.modules.nixos.network-programs
      inputs.self.modules.nixos.shell-programs

      inputs.self.modules.nixos.wsl

      inputs.self.modules.nixos.unfree
    ];
  };
}
