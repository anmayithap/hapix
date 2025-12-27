# =========================================================================
# == USER PROFILE: rusel (Zsh Plugins)
# This module enriches the Zsh environment with specialized plugins.
# It focuses on intelligent completions, advanced history navigation,
# and developer ergonomics (Vi-mode and Nix-specific tooling).
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Zsh Plugin Registry
    # -----------------------------------------------------------------------
    # We use 'lib.mkBefore' to ensure these foundational plugins are loaded
    # early in the shell initialization process.
    programs.zsh.plugins = lib.mkBefore [
      # ### General Completions
      # Adds a massive collection of additional completion definitions
      # for various CLI tools not covered by standard Zsh.
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
        completions = ["share/zsh/site-functions"];
      }

      # ### Nix Ecosystem Completions
      # Specialized completions for Nix-specific commands (nix-env,
      # nix-shell, etc.), providing a better UX for flake management.
      {
        name = "nix-zsh-completions";
        src = pkgs.nix-zsh-completions;
        file = "share/zsh/plugins/nix/nix.plugin.zsh";
        completions = ["share/zsh/site-functions"];
      }

      # ### History Substring Search
      # Allows searching through command history by typing a part of the
      # command and using Up/Down arrows to filter matches.
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file = "share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh";
      }

      # ### Alias Reminders (You-Should-Use)
      # Analyzes executed commands and reminds the user if an existing
      # alias could have been used instead. Ideal for building muscle
      # memory for system-level aliases like 'nixh'.
      {
        name = "zsh-you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/zsh-you-should-use/zsh-you-should-use.plugin.zsh";
      }

      # ### Advanced Vi-Mode
      # A highly refined Vi-mode implementation that provides better
      # visual indicators and more robust keybindings than the
      # standard Zsh 'bindkey -v'.
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
}
