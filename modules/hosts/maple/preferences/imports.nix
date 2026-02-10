# ----------------------------------------------------------------------------
# ## Maple Host Module: [Preferences]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  # ## Apply generic preferences
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    preferences
  ];

  # ## Apply darwin only preferences
  flake.modules.darwin.maple.imports = with inputs.self.modules.darwin; [
    preferences
  ];
}
