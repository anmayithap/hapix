# =========================================================================
# == USER PROFILE: rusel (FZF Interactive Completion Adapter)
# This module integrates 'fzf-tab' into Zsh, replacing the standard
# completion menu with an interactive fuzzy-finder. It establishes
# context-aware previews for directories and files using 'eza' and 'bat'.
# =========================================================================
{
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Zsh Plugin: fzf-tab
    # -----------------------------------------------------------------------
    # Replaces the default Zsh completion selection menu with fzf.
    programs.zsh.plugins = lib.mkAfter [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    # -----------------------------------------------------------------------
    # ## Completion Tuning (zstyle)
    # -----------------------------------------------------------------------
    # Configures the visual behavior and preview logic for fzf-tab.
    programs.zsh.initContent = lib.mkOrder 1000 ''
      # ### UI Scaling
      # Ensure the fzf window has enough vertical space for previews.
      zstyle ':fzf-tab:*' fzf-min-height 15

      # ### Navigation Previews
      # Show directory contents using 'eza' when completing arguments
      # for navigation and listing tools.
      zstyle ':fzf-tab:complete:(cd|z|ls|lsd|eza):*' fzf-preview \
        'eza -1 $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview \
        'eza -1 $realpath'

      # ### General Purpose Previews
      # Smart preview logic:
      # - Directories: Render a single-column list via 'eza'.
      # - Files: Render syntax-highlighted content via 'bat'.
      zstyle ':fzf-tab:complete:*:*' fzf-preview \
        'if [ -d $realpath ]; then
          eza -1 $realpath
        else
          bat --style=numbers --color=always --line-range :500 $realpath
        fi'

      # ### Interaction Settings
      # Inherit global FZF_DEFAULT_OPTS (colors, layout) for consistency.
      zstyle ':fzf-tab:*' use-fzf-default-opts yes

      # Use '<' and '>' to switch between completion groups
      # (e.g., switching from 'files' to 'directories').
      zstyle ':fzf-tab:*' switch-group '<' '>'
    '';
  };
}
