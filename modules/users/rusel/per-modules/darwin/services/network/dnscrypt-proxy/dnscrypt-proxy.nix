# =========================================================================
# == SHARED DARWIN MODULE: DNSCrypt-Proxy (Privacy Resolver)
# This module implements a local, encrypted DNS resolver. It enhances
# privacy by preventing DNS hijacking and eavesdropping, while optimizing
# lookup speeds through local caching and forced TCP transport for
# improved reliability on modern networks.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User DNS Registry
  # -----------------------------------------------------------------------
  # We register this configuration under the 'rusel' Darwin profile.
  # This provides a unified privacy layer that is automatically applied
  # to any macOS host used by the 'rusel' user.
  flake.modules.darwin.rusel = {lib, ...}: {
    services.dnscrypt-proxy = {
      # ### Service Activation
      # Enable the DNSCrypt-Proxy daemon.
      enable = lib.mkDefault true;

      # -----------------------------------------------------------------------
      # ## Resolver Settings
      # -----------------------------------------------------------------------
      settings = {
        # ### Upstream Providers
        # We specify our preferred resolvers.
        # - 'geohide': A specialized provider likely used for regional routing.
        # - 'cloudflare': A reliable, low-latency global privacy provider.
        server_names = [
          "geohide"
          "cloudflare"
        ];

        # ### Load Balancing Strategy
        # 'first' tells the proxy to always try the first server in the
        # list (geohide) and only failover to the next if it's unavailable.
        # This ensures our preferred regional routing is prioritized.
        lb_strategy = "first";

        # ### Custom Server Definition (Stamps)
        # We define the 'geohide' server using a DNS Stamp.
        # Stamps encapsulate all the info (IP, Port, Hash, Path) needed
        # to connect to an encrypted resolver in a single string.
        static = {
          geohide = {
            stamp = "sdns://AgcAAAAAAAAAAAASZG5zLmdlb2hpZGUucnU6NDQ0Ci9kbnMtcXVlcnk";
          };
        };

        # ### Networking & Transport
        # Listen on the standard DNS port on the local loopback interface.
        # This allows you to set your macOS System Settings DNS to 127.0.0.1.
        listen_addresses = [
          "127.0.0.1:53"
        ];

        # Force all DNS traffic over TCP.
        # This is more reliable for encrypted traffic and prevents certain
        # types of UDP-based amplification attacks or ISP throttling.
        force_tcp = true;
        ipv6_servers = false;

        # ### Performance & Logging
        # Enable a local cache to prevent redundant network requests.
        cache = true;
        cache_size = 512;

        # Set log level to 0 (errors only) to reduce disk I/O and
        # maintain maximum privacy for DNS queries.
        log_level = 0;
      };
    };
  };
}
