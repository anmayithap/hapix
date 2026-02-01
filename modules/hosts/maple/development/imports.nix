# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Importing all development modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    development
  ];
}
