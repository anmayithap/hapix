# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Terminal Emulators]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-terminal-emulators = {
    imports = [
      inputs.self.modules.homeManager.rusel-alacritty
      inputs.self.modules.homeManager.rusel-ghostty
    ];
  };
}
