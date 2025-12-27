# =========================================================================
# == USER PROFILE: rusel (CLI Enhancement - bat)
# This module enables 'bat', a modern replacement for the 'cat' command.
# It provides advanced features like syntax highlighting for a wide range
# of programming languages and markdown, integrated line numbers, and
# Git-aware gutter indicators.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.bat = {
      # ### Core Activation
      # Force-enable 'bat' as the primary text-viewing utility.
      #
      # Using 'lib.mkForce' ensures that this productivity enhancement
      # remains active for the "rusel" profile, overriding any generic
      # or minimal system defaults.
      enable = lib.mkForce true;

      # Note: Visual integration (aliases and previews) is handled by
      # the corresponding 'bat/+adapter.nix' module.
    };
  };
}
