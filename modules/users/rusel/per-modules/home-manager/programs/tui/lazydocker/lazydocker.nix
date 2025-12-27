# =========================================================================
# == USER PROFILE: rusel (Docker Management - lazydocker)
# This module configures 'lazydocker', a simple terminal UI for both docker
# and docker-compose. It provides a keyboard-driven interface for
# managing containers, images, and volumes, significantly reducing the
# friction of container-based development.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.lazydocker = {
      # ### Core Activation
      # Enable lazydocker globally for the user.
      #
      # We use 'lib.mkDefault' to ensure that this observability tool is
      # available by default across the "rusel" environment while allowing
      # for host-specific exclusions on minimal or headless systems.
      enable = lib.mkDefault true;

      # Note: lazydocker effectively replaces manual 'docker ps',
      # 'docker logs', and 'docker-compose down/up' workflows with
      # an interactive, high-visibility dashboard.
    };
  };
}
