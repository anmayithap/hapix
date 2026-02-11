# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Services > Containerization]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-containerization = {
    imports = [
      inputs.self.modules.homeManager.rusel-colima
      inputs.self.modules.homeManager.rusel-docker
    ];
  };
}
