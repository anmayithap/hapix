# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Importing all preferences modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    preferences
  ];
  flake.modules.darwin.maple.imports = with inputs.self.modules.darwin; [
    preferences
  ];
}
