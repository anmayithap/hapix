# ----------------------------------------------------------------------------
# ## Generic Module: [Preferences]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.preferences = {
    imports = [
      inputs.self.modules.generic.documentation
      inputs.self.modules.generic.fonts
      inputs.self.modules.generic.nix-channels
      inputs.self.modules.generic.nix-features
      inputs.self.modules.generic.nix-gc
      inputs.self.modules.generic.nix-trust
      inputs.self.modules.generic.time
    ];
  };
}
