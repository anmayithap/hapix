# =========================================================================
# == SHARED DARWIN MODULE: Networking Infrastructure
# This module defines the baseline networking hardware and resolution
# settings for macOS. It ensures that the system correctly identifies
# physical interfaces (like Wi-Fi and Ethernet) and provides a hook for
# early-stage DNS configuration.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Networking Logic Definition
  # -----------------------------------------------------------------------
  networking = {lib, ...}: {
    networking = {
      # ### Network Interface Recognition
      # We define a list of known network services that nix-darwin is
      # allowed to manage.

      knownNetworkServices = lib.mkBefore [
        "Wi-Fi"
        "Ethernet Adaptor"
      ];

      # ### Domain Name System (DNS)
      # Placeholder for global DNS servers.

      dns = lib.mkBefore [];
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # This registers the networking component into our internal Darwin
  # module library. It is typically consumed by the 'rusel' base profile
  # to provide a sane default network environment for all Mac hosts.
  flake.modules.darwin = {inherit networking;};
}
