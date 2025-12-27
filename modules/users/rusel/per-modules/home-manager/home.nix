# =========================================================================
# == USER PROFILE: rusel (Home Manager Core)
# This module initializes the fundamental Home Manager settings for the
# "rusel" user. It synchronizes the environment with the shared 'user-meta'
# identity, establishing the username, home directory path, and the
# configuration state version across all platforms.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Environment Registry
  # -----------------------------------------------------------------------
  # We register these core settings within the 'rusel' Home Manager profile.
  # This ensures that whenever the "rusel" environment is instantiated
  # (on macOS, NixOS, or WSL), it inherits the correct ownership and
  # compatibility baseline.
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: let
    # We extract the identity details from our unified 'user-meta' schema.
    # This maintains the "Single Source of Truth" principle—if the
    # identity changes in the metadata module, Home Manager updates
    # automatically.
    inherit (config.user-meta) username homeDirectory;
  in {
    # ### Account Identity
    # Tells Home Manager which system user owns this configuration.
    home.username = lib.mkDefault username;

    # ### Filesystem Path
    # The absolute path to the user's home folder. This is calculated
    # dynamically in 'user-meta.nix' (e.g., /Users/rusel or /home/rusel).
    home.homeDirectory = lib.mkDefault homeDirectory;

    # -----------------------------------------------------------------------
    # ## State Version
    # -----------------------------------------------------------------------
    # The state version identifies the default values for various
    # Home Manager options.
    #
    # We set this to "25.11" to align with the latest NixOS release
    # cycle (late 2025). This ensures that our configuration remains
    # compatible with the expected behaviors of this version, even if
    # future Home Manager updates change their internal defaults.
    home.stateVersion = lib.mkDefault "25.11";
  };
}
