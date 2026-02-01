# ----------------------------------------------------------------------------
# ## Darwin Networking Preferences Module
# ----------------------------------------------------------------------------
{
  flake.modules.darwin.networking = {lib, ...}: {
    networking = {
      knownNetworkServices = lib.mkBefore [
        "Wi-Fi"
        "Ethernet Adaptor"
      ];

      dns = lib.mkBefore [];
    };
  };
}
