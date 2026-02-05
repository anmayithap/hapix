# ----------------------------------------------------------------------------
# ## Flake Module: Setting up metadata for flake
# ----------------------------------------------------------------------------
{lib, ...}: {
  flake.meta = {
    uri = lib.mkForce "github:anmayithap/hapix";
  };
}
