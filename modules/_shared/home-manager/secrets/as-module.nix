# ----------------------------------------------------------------------------
# ## Home Manager Module: [Secrets] configuration
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.homeManager.secrets = {
    imports = [
      inputs.self.modules.homeManager.agenix
    ];
  };
}
