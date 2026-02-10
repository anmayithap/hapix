# ----------------------------------------------------------------------------
# ## Maple Host Module: [HomeManager]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    homeManager
  ];
}
