{inputs, ...}: {
  flake.modules.darwin.darwin.imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-index-database.darwinModules.nix-index
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.agenix.darwinModules.default

    inputs.self.modules.darwin.nix-settings
    inputs.self.modules.darwin.unfree
    inputs.self.modules.darwin.time
    inputs.self.modules.darwin.fonts
    inputs.self.modules.darwin.networking
    inputs.self.modules.darwin.documentation
    inputs.self.modules.darwin.environment
    inputs.self.modules.darwin.system
    inputs.self.modules.darwin.power
    inputs.self.modules.darwin.security
    inputs.self.modules.darwin.system-packages
    inputs.self.modules.darwin.nix-index-database
    inputs.self.modules.darwin.homebrew
    inputs.self.modules.darwin.nix-homebrew
    inputs.self.modules.darwin.agenix
  ];
}
