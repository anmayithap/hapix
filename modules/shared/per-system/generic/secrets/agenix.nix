# ----------------------------------------------------------------------------
# ## Agenix Module: Configures default agenix preferences
# ----------------------------------------------------------------------------
{
  flake.modules.generic.agenix = {lib, ...}: {
    age = {
      identityPaths = lib.mkBefore [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };
  };
}
