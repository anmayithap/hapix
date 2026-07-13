# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Terminal Emulators]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.terminal-emulators = {
    imports = [
      inputs.self.modules.homeManager.ghostty
      inputs.self.modules.homeManager.alacritty
    ];
  };
}
