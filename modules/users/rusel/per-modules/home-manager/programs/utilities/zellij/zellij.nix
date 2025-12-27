# =========================================================================
# == USER PROFILE: rusel (Terminal Multiplexer - Zellij)
# This module configures Zellij, a modern terminal workspace and
# multiplexer. It prioritizes a clean, distraction-free startup experience
# and synchronizes the visual aesthetic with the global "Ayu Dark" theme
# used across the environment.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zellij = {
      # ### Core Activation
      # Force-enable Zellij as the primary terminal multiplexer.
      # Using 'lib.mkForce' ensures that this Rust-powered workspace
      # engine is standard across all hosts in the "rusel" profile.
      enable = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Zellij Settings (config.kdl)
      # -----------------------------------------------------------------------
      settings = {
        # #### Aesthetics
        # Synchronize with the 'ayu_dark' palette used in Alacritty to
        # ensure a cohesive visual environment.
        theme = "ayu_dark";

        # #### Startup Behavior (Noise Reduction)
        # Suppress non-essential information during launch to maintain
        # a minimalist and professional terminal experience.
        show_release_notes = false;
        show_startup_tips = false;
      };
    };
  };
}
