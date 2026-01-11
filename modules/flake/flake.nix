# ----------------------------------------------------------------------------
# ## Metadata: Setting up metadata for flake
# ----------------------------------------------------------------------------
{lib, ...}: {
  config.flake = {
    meta = {
      uri = lib.mkDefault "github:anmayithap/hapix";
    };
  };
}
