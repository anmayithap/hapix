# =========================================================================
# == USER PROFILE: rusel (System Information - fastfetch)
# This module enables 'fastfetch', a modern and high-performance system
# information tool. It provides a visually appealing summary of system
# metadata (OS, Kernel, Uptime, Hardware) upon execution, serving as
# the definitive successor to neofetch.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.fastfetch = {
      # ### Core Activation
      # Force-enable fastfetch globally for the user profile.
      #
      # Using 'lib.mkForce' ensures that this diagnostic utility is
      # always available in the "rusel" environment, regardless of
      # any minimal system-level defaults.
      enable = lib.mkForce true;

      # Note: Standard shell integration (aliasing 'ff' to 'fastfetch')
      # is managed by the corresponding 'fastfetch/+adapter.nix' module.
    };
  };
}
