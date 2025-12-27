# =========================================================================
# == USER PROFILE: rusel (Fuzzy Finder - fzf)
# This module configures 'fzf', the command-line fuzzy finder. It defines
# a minimalist, high-visibility UI with optimized layouts for previews
# and interactive history searching, serving as the interface for
# filtered navigation and selection.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.fzf = {
      # ### Core Activation
      # Force-enable fzf globally for the user.
      enable = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Global UI Options
      # -----------------------------------------------------------------------
      # These flags affect the general appearance and behavior of fzf
      # whenever it is invoked.
      defaultOptions = lib.mkBefore [
        # #### Layout & Dimensions
        "--height 40%" # Occupy only a portion of the terminal.
        "--layout=reverse" # Display the search prompt at the top.
        "--border" # Add a subtle frame around the finder.
        "--info=inline" # Display match counts next to the query.

        # #### Minimalist Interface Icons
        ''--prompt="❯ "''
        ''--pointer="❯ "''
        ''--marker="❯ "''

        # #### Preview Window Configuration
        # Positions previews to the right, taking up 50% of the fzf window.
        "--preview-window=right:50%:border-block"

        # #### Interaction Bindings
        # 'Ctrl+/': Quickly hide or show the preview pane.
        "--bind 'ctrl-/:toggle-preview'"
      ];

      # -----------------------------------------------------------------------
      # ## History Widget Tuning (Ctrl+R)
      # -----------------------------------------------------------------------
      # Specific refinements for searching through shell history.
      historyWidgetOptions = lib.mkBefore [
        "--sort" # Prioritize relevance in history matches.
        "--exact" # Prefer literal matches over fuzzy ones for commands.

        # Override preview layout for history to maximize vertical space.
        "--preview-window down:3:wrap"
      ];
    };
  };
}
