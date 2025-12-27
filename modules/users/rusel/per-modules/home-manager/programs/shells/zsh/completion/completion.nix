# =========================================================================
# == USER PROFILE: rusel (Zsh Completion Engine Activation)
# This module serves as the primary toggle for the Zsh completion system.
# It ensures that the core 'compsys' engine is initialized, providing the
# foundation for all advanced tab-completion features, menu selections,
# and plugin-based completions across the environment.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh = {
      # ### Core Completion Activation
      # Force-enables the Zsh completion system.
      #
      # This option triggers 'compinit', which is the prerequisite for:
      # - The advanced 'zstyle' completions defined in our adapters.
      # - Specialized plugin completions (Git, Nix, UV, etc.).
      # - Case-insensitive matching and interactive selection menus.
      #
      # Using `lib.mkForce` ensures that the shell remains fully
      # functional and interactive even if imported into a more
      # restrictive or minimal system profile.
      enableCompletion = lib.mkForce true;
    };
  };
}
