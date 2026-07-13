# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Security]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.security = {
    imports = [
      inputs.self.modules.homeManager.keepassxc
      inputs.self.modules.homeManager.ssh
    ];
  };
}
