# ----------------------------------------------------------------------------
# ## Home Manager: [Programs > Shells > rusel] configuration
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-shells = {
    imports = [
      inputs.self.modules.homeManager.rusel-zsh
      inputs.self.modules.homeManager.rusel-fish
    ];
  };
}
