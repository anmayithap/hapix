# ----------------------------------------------------------------------------
# ## Host Specific Profiles (maple)
# ----------------------------------------------------------------------------
{inputs, ...}: {
  # ----------------------------------------------------------------------------
  # ## Automatic module registration.
  # Here we register specific modules for the host.
  # ----------------------------------------------------------------------------
  flake.modules.darwin.maple.imports = with inputs.self.modules.darwin; [
    # ## Profiles
    rusel
  ];
}
