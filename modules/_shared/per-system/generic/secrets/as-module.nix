# ----------------------------------------------------------------------------
# ## Generic Module: [Secrets]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.secrets = {
    imports = [
      inputs.self.modules.generic.agenix
    ];
  };
}
