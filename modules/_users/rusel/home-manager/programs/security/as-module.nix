# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Security]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-security = {
    imports = [
      inputs.self.modules.homeManager.rusel-keepassxc
      inputs.self.modules.homeManager.rusel-ssh
    ];
  };
}
