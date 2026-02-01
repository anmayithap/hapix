# ----------------------------------------------------------------------------
# ## WSL System Preferences Module: Importing all WSL system preferences
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.nixos.preferences = {
    imports = [
      inputs.self.modules.nixos.wsl
    ];
  };
}
