# =========================================================================
# == USER PROFILE: rusel (Git Management - lazygit)
# This module configures 'lazygit', a fast and intuitive terminal UI for
# Git. It provides a visual, keyboard-driven interface for complex
# operations such as interactive rebasing, hunk staging, and conflict
# resolution, streamlining the Git workflow within the terminal.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.lazygit = {
      # ### Core Activation
      # Enable lazygit globally for the user profile.
      #
      # Using 'lib.mkDefault' ensures that this productivity tool is
      # standard across all "rusel" environments while remaining
      # overrideable for minimalist or non-development hosts.
      enable = lib.mkDefault true;

      # Note: lazygit complements our extensive Git aliases and
      # 'zsh-forgit' integration by providing a high-level dashboard
      # for managing repository state without leaving the CLI.
    };
  };
}
