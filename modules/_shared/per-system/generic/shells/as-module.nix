# ----------------------------------------------------------------------------
# ## Generic Module: [Programs > Shells]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.shells = {
    imports = [
      inputs.self.modules.generic.zsh
      inputs.self.modules.generic.fish
    ];
  };
}
