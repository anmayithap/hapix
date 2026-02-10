# ----------------------------------------------------------------------------
# ## Maple Host Module: [Utils]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    utils
  ];
}
