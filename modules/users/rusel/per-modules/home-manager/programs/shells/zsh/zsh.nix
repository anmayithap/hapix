# =========================================================================
# == USER PROFILE: rusel (Zsh Shell Configuration)
# This module defines the interactive Zsh environment for the "rusel" user.
# It prioritizes professional shell behaviors, including Vi-mode
# keybindings, advanced globbing, and an organized filesystem layout
# through a custom configuration directory.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    config,
    ...
  }: {
    programs.zsh = {
      # ### Core Activation
      # Force-enable Zsh as the primary interactive shell for the user.
      enable = lib.mkForce true;

      # ### Automatic Navigation
      # Allows changing directories by just typing the path (no 'cd' required).
      autocd = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Keymap & Interactivity
      # -----------------------------------------------------------------------
      # Sets the default keybinding mode to 'viins' (Vi Insert Mode).
      # This enables a hybrid workflow where the shell behaves like a
      # standard editor by default, but allows switching to Vi command
      # mode for advanced text manipulation.
      defaultKeymap = lib.mkForce "viins";

      # ### Syntax Highlighting
      # Provides real-time visual feedback by highlighting valid commands,
      # paths, and syntax errors directly in the command line.
      syntaxHighlighting.enable = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Directory Management (Clean Home)
      # -----------------------------------------------------------------------
      # Relocates Zsh-specific files (.zshrc, .zprofile, etc.) from the
      # home root to a hidden '.config/zsh' subdirectory.
      #
      # This supports our "Clean Home" philosophy and keeps the root
      # of the home directory free of shell-specific clutter.
      dotDir = lib.mkForce "${config.xdg.configHome}/zsh";

      # -----------------------------------------------------------------------
      # ## Shell Options (Setopt)
      # -----------------------------------------------------------------------
      # Configures internal Zsh behaviors using 'setopt'. We use 'lib.mkBefore'
      # to ensure these core options are applied before any plugin-specific
      # configurations.
      setOptions = lib.mkBefore [
        # #### Globbing (Pattern Matching)
        "EXTENDED_GLOB" # Enable advanced pattern matching (e.g., ^, #, ~).
        "NO_NOMATCH" # Don't error if a glob doesn't match; pass it as literal.
        "NO_CASE_GLOB" # Case-insensitive pattern matching.

        # #### Completion Engine
        "AUTO_LIST" # Automatically list choices on ambiguous completion.
        "AUTO_MENU" # Show completion menu on successive tab presses.
        "AUTO_PARAM_SLASH" # Add a trailing slash when completing a directory.
        "COMPLETE_IN_WORD" # Allow completion from within a word, not just at the end.

        # #### General Interaction
        "INTERACTIVE_COMMENTS" # Allow comments (starting with #) in interactive shell.
        "PROMPT_SUBST" # Enable parameter expansion and command substitution in prompts.
        "CORRECT" # Enable "Spelling Correction" for commands.
      ];
    };
  };
}
