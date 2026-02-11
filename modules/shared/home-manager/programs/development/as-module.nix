# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Development]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.development = {
    imports = [
      inputs.self.modules.homeManager.direnv
      inputs.self.modules.homeManager.mise
      inputs.self.modules.homeManager.git
      inputs.self.modules.homeManager.uv
    ];
  };
}
