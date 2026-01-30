# ----------------------------------------------------------------------------
# ## Shells Module: Importing all shells modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.shells = {
    imports = [
      inputs.self.modules.generic.zsh
    ];
  };
}
