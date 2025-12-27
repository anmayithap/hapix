# =========================================================================
# == USER PROFILE: rusel (Search Utility - ripgrep)
# This module enables 'ripgrep' (rg), a high-performance, line-oriented
# search tool. It serves as the primary engine for pattern matching
# across the filesystem, offering world-class speed and intelligent
# defaults that respect version control settings.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.ripgrep = {
      # ### Core Activation
      # Force-enable ripgrep globally for the user profile.
      #
      # Using 'lib.mkForce' ensures that this essential developer tool
      # is always present in the "rusel" environment, overriding any
      # minimal system-level defaults.
      enable = lib.mkForce true;

      # Note: ripgrep is the preferred search backend for modern editors
      # like Neovim (via Telescope) and is integrated into the shell
      # via the 'ripgrep/+adapter.nix' alias module.
    };
  };
}
