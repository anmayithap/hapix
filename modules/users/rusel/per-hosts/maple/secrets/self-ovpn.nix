# =========================================================================
# == USER PROFILE: rusel (Host-Specific Secrets - maple)
# This module manages sensitive configurations specific to the "maple"
# environment. It leverages agenix to decrypt host-specific VPN profiles,
# ensuring that the "maple" workstation has its dedicated network
# credentials available in a secure, declarative manner.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Home Manager Secret Registration
  # -----------------------------------------------------------------------
  # We continue extending the 'rusel' Home Manager registry. This module
  # safely co-exists with other secret modules (like 'tat.ovpn') through
  # the merging capabilities of the Nix module system.
  flake.modules.homeManager.rusel = {config, ...}: let
    # Access the private 'secrets' flake input.
    inherit (inputs) secrets;
  in {
    age = {
      # ### Secret Definitions
      # Each attribute represents an encrypted file that will be
      # decrypted into the user's environment during activation.
      secrets = {
        # #### Host-Specific VPN Profile (maple.ovpn)
        # This profile is likely tailored for the 'maple' workstation,
        # containing specific routes or certificates required for
        # that machine's primary networking tasks.
        "maple.ovpn" = {
          # The source encrypted file within the private secrets repository.
          file = "${secrets}/maple.ovpn.age";

          # Permissions: Symbolic representation of 444 (Read-only for all).
          # This protects the configuration from accidental edits while
          # remaining readable by VPN clients (e.g., Tunnelblick or OpenVPN CLI).
          mode = "a+rwx,u-wx,g-wx,o-wx";

          # Target Destination: ~/.config/vpn/ovpn/maple.ovpn
          # Using XDG variables ensures path consistency across Darwin hosts.
          path = "${config.xdg.configHome}/vpn/ovpn/maple.ovpn";

          # Symlink: Links the target path to the decrypted secret
          # in the temporary agenix secure storage.
          symlink = true;
        };
      };
    };
  };
}
