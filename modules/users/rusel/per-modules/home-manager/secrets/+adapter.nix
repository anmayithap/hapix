# =========================================================================
# == USER PROFILE: rusel (SSH Secret Integration Adapter)
# This module integrates specialized SSH configuration files into the
# global SSH client setup. It enables a modular approach to SSH management,
# allowing for the inclusion of external host definitions (e.g., corporate
# or VPN-specific configs) while maintaining a clean primary configuration.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: let
    # Extract home path from the unified user-meta profile.
    inherit (config.user-meta) homeDirectory;
  in {
    # -----------------------------------------------------------------------
    # ## SSH Client Extensions
    # -----------------------------------------------------------------------
    programs.ssh = {
      # ### External Configuration Sourcing
      # We use 'includes' to append an 'Include' directive to the top-level
      # ~/.ssh/config file.
      #
      # Using 'lib.mkAfter' ensures that these specific host definitions
      # are processed after our global security defaults and match blocks,
      # allowing the main config to provide the cryptographic baseline
      # while this file provides the specific routing.
      includes = lib.mkAfter [
        # #### Corporate/VPN SSH Config
        # This file likely contains host definitions, proxy commands,
        # and identity mappings for internal infrastructure.
        "${homeDirectory}/.ssh/ssh_tatitneft_config"
      ];
    };
  };
}
