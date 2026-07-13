# ----------------------------------------------------------------------------
# ## WSL Module: [Preferences]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.nixos.preferences = {
    imports = [
      inputs.self.modules.nixos.wsl
    ];
  };
}
