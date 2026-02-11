# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Notes]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.notes = {
    imports = [
      inputs.self.modules.homeManager.obsidian
    ];
  };
}
