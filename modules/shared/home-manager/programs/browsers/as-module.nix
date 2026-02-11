# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Browsers]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.browsers = {
    imports = [
      inputs.self.modules.homeManager.firefox
    ];
  };
}
