# ----------------------------------------------------------------------------
# ## Rusel Home Manager: Secrets section configuration
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.rusel-secrets = {
    imports = [
      inputs.self.modules.homeManager.rusel-agenix
    ];
  };
}
