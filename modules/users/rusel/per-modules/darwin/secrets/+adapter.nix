# =========================================================================
# == SHARED DARWIN MODULE: DNS Privacy & Routing (dnscrypt-proxy)
# This module configures advanced DNS routing for the "rusel" profile.
# It leverages dnscrypt-proxy for encrypted DNS lookups and uses agenix
# to securely manage domain-specific forwarding rules, ensuring that
# private infrastructure lookups remain confidential.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User DNS Registry
  # -----------------------------------------------------------------------
  # We register this configuration under the 'rusel' Darwin profile.
  # It complements the system-level networking modules by adding
  # user-specific privacy and connectivity logic.
  flake.modules.darwin.rusel = {config, ...}: {
    services.dnscrypt-proxy = {
      # ### DNSCrypt Settings
      settings = {
        # #### Forwarding Rules (Conditional DNS)
        # This setting defines a path to a file containing rules for
        # domain-based routing (e.g., forwarding *.internal.net to 10.0.0.1).
        #
        # We point this directly to the decrypted path of an agenix secret.
        # This is a critical security pattern:
        # 1. It keeps internal company/private domain names out of the
        #    public Nix configuration.
        # 2. It ensures the proxy only sees the rules after the
        #    host has successfully decrypted its secrets.
        forwarding_rules = config.age.secrets."forwarding-rules".path;
      };
    };
  };
}
