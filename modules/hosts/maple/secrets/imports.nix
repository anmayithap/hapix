# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Importing all secrets modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = [
    inputs.self.modules.generic.secrets
  ];
}
