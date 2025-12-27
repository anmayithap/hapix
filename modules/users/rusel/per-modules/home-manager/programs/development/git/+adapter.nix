# =========================================================================
# == USER PROFILE: rusel (Git Shell Integration Adapter)
# This module integrates advanced Git interactive tools into the Zsh shell.
# It leverages 'forgit' for fzf-powered Git workflows and tunes the shell
# completion engine for more intuitive branch and checkout navigation.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Zsh Plugin: forgit
    # -----------------------------------------------------------------------
    # 'forgit' provides interactive, fzf-based interfaces for common Git
    # commands (e.g., interactive add, checkout, diff, and stash).
    programs.zsh.plugins = lib.mkAfter [
      {
        name = "zsh-forgit";
        src = pkgs.zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";

        # Ensures that forgit's completion scripts are correctly
        # identified by the Zsh completion system.
        completions = [
          "share/zsh/site-functions"
        ];
      }
    ];

    # -----------------------------------------------------------------------
    # ## Completion Tuning
    # -----------------------------------------------------------------------
    # Customizes how Zsh handles Git-specific completions.
    programs.zsh.initContent = lib.mkOrder 1000 ''
      # ### Disable Sorting for Checkout
      # By disabling sorting for 'git-checkout', we preserve the order
      # provided by Git (which is often chronological/relevance-based)
      # instead of forcing an alphabetical sort.
      zstyle ':completion:*:git-checkout:*' sort false
    '';
  };
}
