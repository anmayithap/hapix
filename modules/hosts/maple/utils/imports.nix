# ----------------------------------------------------------------------------
# ## Maple Host Configuration: Importing all utils modules
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.maple.imports = with inputs.self.modules.generic; [
    utils
  ];
}
