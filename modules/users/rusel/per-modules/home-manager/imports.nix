{inputs, ...}: {
  flake.modules.homeManager.rusel.imports = [
    inputs.agenix.homeManagerModules.default

    inputs.self.modules.homeManager.nix-index

    inputs.self.modules.homeManager.user-meta

    inputs.self.modules.homeManager.services
    inputs.self.modules.homeManager.programs

    inputs.self.modules.homeManager.unfree
  ];

  flake.homeModules.rusel.imports = [
    inputs.self.modules.homeManager.rusel
  ];
}
