{inputs, ...}: {
  flake.modules.darwin.darwin.imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-index-database.darwinModules.nix-index
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.agenix.darwinModules.default

    inputs.self.modules.darwin.documentation
    inputs.self.modules.darwin.environment
    inputs.self.modules.darwin.fonts
    inputs.self.modules.darwin.nix-settings
    inputs.self.modules.darwin.time

    inputs.self.modules.darwin.nix-index-database
    inputs.self.modules.darwin.secrets

    inputs.self.modules.darwin.system-programs
    inputs.self.modules.darwin.editor-programs
    inputs.self.modules.darwin.language-programs
    inputs.self.modules.darwin.network-programs
    inputs.self.modules.darwin.shell-programs

    inputs.self.modules.darwin.networking
    inputs.self.modules.darwin.power
    inputs.self.modules.darwin.system
    inputs.self.modules.darwin.homebrew
    inputs.self.modules.darwin.security
    inputs.self.modules.darwin.nix-homebrew

    inputs.self.modules.darwin.unfree
  ];
}
