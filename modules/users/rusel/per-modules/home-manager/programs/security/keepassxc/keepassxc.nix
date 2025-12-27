# =========================================================================
# == USER PROFILE: rusel (Security & Password Management - KeePassXC)
# This module configures KeePassXC, a cross-platform, open-source password
# manager. It provides a secure, local-first vault for credentials and
# integrates with web browsers while respecting the immutability of the
# Nix store.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.keepassxc = {
      # ### Core Activation
      # Force-enable KeePassXC as the primary password management utility.
      # Using `lib.mkForce` ensures this security-critical tool is present
      # across all managed environments (Darwin and NixOS).
      enable = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Browser Integration Settings
      # -----------------------------------------------------------------------
      settings = {
        Browser = {
          # ### Binary Path Management (Nix-Specific)
          # We disable 'UpdateBinaryPath'.
          #
          # In a standard OS, KeePassXC attempts to update the path to its
          # binary in the browser's native messaging host configuration.
          #
          # In Nix, the application binary resides in a read-only path in
          # the /nix/store. Setting this to 'false' prevents the app from
          # attempting to modify immutable files, ensuring that browser
          # extensions can communicate with the vault without errors or
          # permission conflicts.
          UpdateBinaryPath = false;
        };
      };
    };
  };
}
