# =========================================================================
# == USER PROFILE: rusel (DNS System Integration & Activation)
# This module performs the final "glue" logic to ensure macOS utilizes
# the local DNSCrypt-Proxy resolver. It handles privilege management,
# network-level DNS routing, and cache invalidation during system
# activation.
# =========================================================================
{lib, ...}: {
  # -----------------------------------------------------------------------
  # ## User Darwin Registry
  # -----------------------------------------------------------------------
  # We register this integration under the 'rusel' Darwin profile to
  # complete the networking lifecycle for this user.
  flake.modules.darwin.rusel = {
    # ### OS-Level DNS Routing
    # We append '127.0.0.1' (the local loopback) to the system's DNS
    # server list.
    #
    # Using `lib.mkAfter` ensures that this local resolver is prioritized,
    # forcing all system and application traffic through our
    # encrypted dnscrypt-proxy tunnel.
    networking.dns = lib.mkAfter ["127.0.0.1"];

    # -----------------------------------------------------------------------
    # ## Service Privilege Management
    # -----------------------------------------------------------------------
    # By default, macOS restricts binding to ports below 1024 to the
    # root user. Since we configured dnscrypt-proxy to listen on
    # port 53 (the standard DNS port), the service must run as root.
    launchd.daemons.dnscrypt-proxy.serviceConfig = {
      UserName = lib.mkForce "root";
      GroupName = lib.mkForce "wheel";
    };

    # -----------------------------------------------------------------------
    # ## Post-Activation Logic
    # -----------------------------------------------------------------------
    # After a 'nixh' (nh os switch), we need to ensure the system starts
    # using the new DNS settings immediately without a reboot.
    system.activationScripts.postActivation.text = ''
      # ### Flush DNS Cache
      # macOS caches DNS queries in the mDNSResponder service.
      # Sending a HUP (Hang UP) signal forces it to reload and
      # purge its cache, ensuring that the very next query is
      # routed through our newly configured dnscrypt-proxy.
      echo "PostActivation: Flushing macOS DNS cache (mDNSResponder)..."
      sudo killall -HUP mDNSResponder || true
    '';
  };
}
