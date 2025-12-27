# =========================================================================
# == USER PROFILE: rusel (Secrets & VPN Credentials)
# This module orchestrates the decryption of private user secrets using
# agenix. It specifically manages VPN profiles and authentication files,
# ensuring they are placed in XDG-compliant paths with restrictive
# permissions.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Home Manager Secret Registration
  # -----------------------------------------------------------------------
  # We register these secrets under the 'rusel' Home Manager profile.
  # This logic is platform-agnostic and works on both Darwin and NixOS.
  flake.modules.homeManager.rusel = {config, ...}: let
    # We reference the private 'secrets' flake input which contains
    # the encrypted .age files.
    inherit (inputs) secrets;
  in {
    age = {
      # ### Secret Definitions
      # Each attribute corresponds to a decrypted file managed by agenix.
      secrets = {
        # #### OpenVPN Profile (tat.ovpn)
        "tat.ovpn" = {
          # The source path to the encrypted file in the secrets repository.
          file = "${secrets}/tat.ovpn.age";

          # Permissions: 'a+rwx,u-wx,g-wx,o-wx' effectively sets the file
          # to 444 (read-only for all). This ensures the VPN client can
          # read the config while preventing accidental modifications.
          mode = "a+rwx,u-wx,g-wx,o-wx";

          # XDG-Compliant Path: Placed in ~/.config/vpn/ovpn/
          path = "${config.xdg.configHome}/vpn/ovpn/tat.ovpn";

          # Symlink: Create a symlink to the decrypted file in the Nix store.
          symlink = true;
        };

        # #### VPN Credentials (tat.ovpn.auth)
        # This file typically contains the username and password used
        # by the OpenVPN 'auth-user-pass' directive.
        "tat.ovpn.auth" = {
          file = "${secrets}/tat.ovpn.auth.age";
          mode = "a+rwx,u-wx,g-wx,o-wx";

          # Target: ~/.config/vpn/ovpn/tat.ovpn.auth.txt
          path = "${config.xdg.configHome}/vpn/ovpn/tat.ovpn.auth.txt";

          symlink = true;
        };
      };
    };
  };
}
