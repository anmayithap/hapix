# =========================================================================
# == USER PROFILE: rusel (Zsh Autosuggestions)
# This module integrates Fish-like autosuggestions into Zsh. It provides
# real-time, unobtrusive command completions based on shell history,
# significantly increasing terminal productivity and command recall.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh.autosuggestion = {
      # ### Core Activation
      # Force-enable the zsh-autosuggestions plugin. This provides
      # ghost-text suggestions as you type.
      enable = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Suggestion Strategy
      # -----------------------------------------------------------------------
      # Defines the source of truth for generating suggestions.
      #
      # By setting this to ["history"], suggestions are derived
      # exclusively from previous successful commands. This ensures that
      # suggestions are contextually relevant to the user's specific
      # historical workflow.
      strategy = lib.mkForce ["history"];
    };
  };
}
