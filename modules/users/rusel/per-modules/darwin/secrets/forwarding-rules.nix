# =========================================================================
# == USER PROFILE: rusel (DNSCrypt Forwarding Secrets)
# This module orchestrates the decryption and deployment of private DNS
# forwarding rules. It ensures that sensitive internal domain mappings
# are managed securely via agenix and placed in a location where the
# dnscrypt-proxy service can consume them.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Home Manager Secret Registration
  # -----------------------------------------------------------------------
  # We extend the 'rusel' Darwin profile to handle DNS-specific secrets.
  # This module bridges the gap between the encrypted secrets repository
  # and the local service configuration.
  flake.modules.darwin.rusel = {config, ...}: let
    # We extract 'homeDirectory' from our unified 'user-meta' schema
    # to ensure the path is consistent with the rest of the user's
    # configuration environment.
    inherit (config.user-meta) homeDirectory;

    # Access the private 'secrets' flake input containing the .age files.
    inherit (inputs) secrets;
  in {
    age = {
      # ### Secret Definitions
      # We define the source and destination for the encrypted
      # forwarding rules.
      secrets = {
        # #### DNS Forwarding Rules (forwarding-rules)
        # This file contains the "Conditional DNS" logic, mapping
        # specific domains (e.g., corporate or private lab domains)
        # to their respective upstream DNS servers.
        "forwarding-rules" = {
          # The source encrypted file within the private secrets repository.
          file = "${secrets}/forwarding-rules.age";

          # ### Permissions
          # Symbolic representation of 444 (Read-only for all).
          # This allows the 'dnscrypt-proxy' system service to read the
          # file even if it's running under a dedicated service user.
          mode = "a+rwx,u-wx,g-wx,o-wx";

          # ### Target Destination
          # The decrypted file is placed in ~/.config/dnscrypt-proxy/.
          # This follows the standard organization for service-specific
          # user configurations.
          path = "${homeDirectory}/.config/dnscrypt-proxy/forwarding-rules.txt";

          # Symlink: Links the target path to the decrypted secret
          # managed by the agenix service.
          symlink = true;
        };
      };
    };
  };
}
