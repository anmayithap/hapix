# ----------------------------------------------------------------------------
# ## Generic Module: [Secrets > Agenix]
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
