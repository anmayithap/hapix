# =========================================================================
# == USER PROFILE: rusel (Agenix Orchestration Paths)
# This module customizes the internal directory structure for agenix within
# the Home Manager environment. It relocates the secrets storage and
# mount points to an XDG-compliant location, ensuring that sensitive
# transient data is organized and isolated from the home root.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## Home Manager Secret Path Configuration
  # -----------------------------------------------------------------------
  # We extend the 'rusel' profile to refine how agenix manages its
  # temporary and decrypted files.
  flake.modules.homeManager.rusel = {config, ...}: let
    # Extract 'homeDirectory' from our unified identity profile.
    inherit (config.user-meta) homeDirectory;

    # Define a centralized base directory for all agenix-related data
    # following the XDG Clean Home philosophy (~/.config/agenix).
    baseDirectory = homeDirectory + "/.config/agenix";
  in {
    age = {
      # ### Secrets Metadata Directory
      # Defines the path where agenix stores internal state or symlinks
      # related to the secret definitions.
      secretsDir = baseDirectory + "/secrets";

      # ### Secrets Mount Point
      # Defines the actual location where the decrypted secrets are
      # exposed to the system.
      #
      # By using a dedicated 'secrets.d' directory, we provide a
      # stable and isolated environment for the decrypted content
      # before it is symlinked to its final destination (like .ssh or .env).
      secretsMountPoint = baseDirectory + "/secrets.d";
    };
  };
}
