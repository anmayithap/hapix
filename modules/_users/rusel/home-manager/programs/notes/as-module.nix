# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Notes]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-notes = {
    imports = [
      inputs.self.modules.homeManager.rusel-obsidian
    ];
  };
}
