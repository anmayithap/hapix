# ----------------------------------------------------------------------------
# ## Maple Host Module: [Development]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    development
  ];
}
