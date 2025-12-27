# =========================================================================
# == USER PROFILE: rusel (Secret Decryption Identity)
# This module establishes the personal decryption identity for agenix.
# It points to the user's private SSH key, which acts as the "master key"
# to unlock all user-level secrets (VPNs, .env files, SSH keys) managed
# within this Home Manager profile.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## Home Manager Secret Identity
  # -----------------------------------------------------------------------
  # We register the decryption path within the 'rusel' profile. This
  # complements the system-level 'secrets' module by allowing user-specific
  # secrets to be decrypted using a personal identity rather than a
  # machine-wide host key.
  flake.modules.homeManager.rusel = {config, ...}: let
    # Extract 'homeDirectory' to ensure the SSH key path is absolute
    # and consistent across Darwin and NixOS.
    inherit (config.user-meta) homeDirectory;
  in {
    age = {
      # ### Identity Paths
      # The list of private keys used by 'age' to decrypt .age files.
      #
      # We use the standard Ed25519 user key. This allows the user to
      # manage and decrypt their own configuration secrets without
      # requiring administrative access to the system-wide host keys.
      identityPaths = [
        "${homeDirectory}/.ssh/id_ed25519"
      ];
    };
  };
}
