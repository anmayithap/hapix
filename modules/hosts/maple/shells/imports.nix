# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Importing all shells modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    shells
  ];
}
