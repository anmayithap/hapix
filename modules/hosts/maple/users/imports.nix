# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Importing all users modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    rusel
  ];

  flake.modules.darwin.maple.imports = with inputs.self.modules.darwin; [
    rusel
  ];
}
