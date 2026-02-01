# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Importing all editors modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    editors
  ];
}
