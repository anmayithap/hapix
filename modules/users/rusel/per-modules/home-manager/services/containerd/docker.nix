# =========================================================================
# == USER PROFILE: rusel (Containerization - Docker CLI)
# This module configures the Docker command-line interface for the "rusel"
# user. It provides the necessary binaries to interact with container
# runtimes (like Colima) and enforces an XDG-compliant filesystem layout
# to keep the home directory root clean.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Environment Registry
  # -----------------------------------------------------------------------
  # We register these settings within the 'rusel' Home Manager profile.
  # This ensures that the Docker management tools are available and
  # correctly configured across all platforms (macOS and Linux).
  flake.modules.homeManager.rusel = {
    lib,
    config,
    pkgs,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Package Installation
    # -----------------------------------------------------------------------
    home.packages = with pkgs; [
      # ### Docker CLI
      # The primary tool for managing containers, images, and networks.
      # On macOS, this client communicates with the Colima VM configured
      # in our services module.
      docker
    ];

    # -----------------------------------------------------------------------
    # ## Client Configuration (XDG Clean Home)
    # -----------------------------------------------------------------------
    programs.docker-cli = {
      # ### Configuration Directory
      # By default, Docker creates a hidden '.docker' directory at the
      # root of the home folder.
      #
      # We use 'lib.mkForce' to redirect this to an XDG-compliant
      # location (~/.config/docker). This aligns with our global "Clean
      # Home" policy and keeps user-specific configuration data
      # organized.
      configDir = lib.mkForce "${config.xdg.configHome}/docker";
    };
  };
}
