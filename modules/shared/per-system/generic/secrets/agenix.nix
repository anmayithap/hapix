# ----------------------------------------------------------------------------
# ## Agenix Module: Configures default `age` settings
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
