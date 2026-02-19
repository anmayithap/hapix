# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.editors = {
    imports = [
      inputs.self.modules.homeManager.vscode
      inputs.self.modules.homeManager.neovim
    ];
  };
}
