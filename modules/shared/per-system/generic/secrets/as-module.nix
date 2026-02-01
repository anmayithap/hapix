# ----------------------------------------------------------------------------
# ## Secrets Module: Configures default secrets preferences
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.secrets = {
    imports = [
      inputs.self.modules.generic.agenix
    ];
  };
}
