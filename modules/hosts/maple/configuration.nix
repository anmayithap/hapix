# ----------------------------------------------------------------------------
# ## Host Specific Configuration (maple)
# ----------------------------------------------------------------------------
{
  # ----------------------------------------------------------------------------
  # ## Automatic module registration.
  # Here we register specific modules for the host.
  # ----------------------------------------------------------------------------
  flake.modules.darwin.maple.imports = [
    # ## Host Identity (Networking)
    {
      networking.hostName = "maple";
      networking.localHostName = "maple";
      networking.computerName = "maple";
    }
  ];
}
