# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.shells = {
    imports = [
      inputs.self.modules.homeManager.zsh
      inputs.self.modules.homeManager.fish
    ];
  };
}
