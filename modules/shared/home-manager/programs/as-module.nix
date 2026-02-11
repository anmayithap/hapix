# ----------------------------------------------------------------------------
# ## Home Manager: [Programs]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.programs = {
    imports = [
      inputs.self.modules.homeManager.nix-index-database
      inputs.self.modules.homeManager.browsers
      inputs.self.modules.homeManager.notes
      inputs.self.modules.homeManager.security
      inputs.self.modules.homeManager.development
      inputs.self.modules.homeManager.shells
      inputs.self.modules.homeManager.terminal-emulators
      inputs.self.modules.homeManager.tui
      inputs.self.modules.homeManager.utils
      inputs.self.modules.homeManager.editors
    ];
  };
}
