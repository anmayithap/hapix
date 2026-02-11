# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Development]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-development = {
    imports = [
      inputs.self.modules.homeManager.rusel-direnv
      inputs.self.modules.homeManager.rusel-mise
      inputs.self.modules.homeManager.rusel-git
      inputs.self.modules.homeManager.rusel-uv
    ];
  };
}
