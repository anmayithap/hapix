# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Editors]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-editors = {
    imports = [
      inputs.self.modules.homeManager.rusel-vscode
    ];
  };
}
