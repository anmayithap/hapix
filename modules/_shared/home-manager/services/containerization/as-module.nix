# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Containerization]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.containerization = {
    imports = [
      inputs.self.modules.homeManager.colima
      inputs.self.modules.homeManager.docker
    ];
  };
}
