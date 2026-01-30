# ----------------------------------------------------------------------------
# ## Secrets Module: Importing all secrets modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.secrets = {
    imports = [
      inputs.self.modules.generic.agenix
    ];
  };
}
