# ----------------------------------------------------------------------------
# ## Maple Host Module: [Editors]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    editors
  ];
}
