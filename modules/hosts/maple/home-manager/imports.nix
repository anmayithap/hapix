# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Importing all home-manager modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    homeManager
  ];
}
