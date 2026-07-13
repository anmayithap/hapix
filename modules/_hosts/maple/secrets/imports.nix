# ----------------------------------------------------------------------------
# ## Maple Host Module: [Secrets]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = [
    inputs.self.modules.generic.secrets
  ];
}
