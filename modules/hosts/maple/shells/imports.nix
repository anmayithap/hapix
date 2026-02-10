# ----------------------------------------------------------------------------
# ## Maple Host Module: [Shells]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    shells
  ];
}
