# =========================================================================
# == USER PROFILE: rusel (Shell Prompt - Starship)
# This module enables 'starship', the minimal, blazing-fast, and infinitely
# customizable prompt for any shell. It provides a consistent visual
# experience across Darwin and NixOS, offering real-time telemetry on
# Git status, language runtimes, and Nix environment states.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.starship = {
      # ### Core Activation
      # Force-enable starship as the primary shell prompt.
      #
      # Using 'lib.mkForce' ensures that the standard shell prompt is
      # replaced by Starship regardless of any default Zsh or Bash
      # prompt settings established in other modules.
      enable = lib.mkForce true;

      # Note: Starship automatically detects when you are inside a
      # 'nix develop' shell or using 'direnv', providing immediate
      # visual feedback on your current development context.
    };
  };
}
