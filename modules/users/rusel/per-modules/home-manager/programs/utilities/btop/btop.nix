# =========================================================================
# == USER PROFILE: rusel (System Monitor - btop)
# This module enables 'btop', a modern and visually rich resource
# monitor. It provides real-time insights into CPU, memory, disks,
# and network usage with a high-performance, interactive TUI.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.btop = {
      # ### Core Activation
      # Force-enable btop as the primary system monitoring utility.
      # Using 'lib.mkForce' ensures this professional observability
      # tool is present on all hosts within the "rusel" profile,
      # overriding any minimal system defaults.
      enable = lib.mkForce true;

      # Note: Standard shell integration (aliasing 'top' to 'btop')
      # is handled by the corresponding 'btop/+adapter.nix' module.
    };
  };
}
