# =========================================================================
# == USER PROFILE: rusel (Zsh Completion Engine)
# This module optimizes the Zsh completion system (compsys). It configures
# advanced 'zstyle' definitions to enable case-insensitive matching,
# visual colorization, interactive menu selection, and persistent caching
# for high-performance tab-completion.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh = {
      # -----------------------------------------------------------------------
      # ## Shell Completion Tuning (zstyle)
      # -----------------------------------------------------------------------
      # We use 'initContent' with 'lib.mkOrder 1000' to inject these
      # low-level styles after core Zsh initialization but before
      # specific user scripts.
      initContent = lib.mkOrder 1000 ''
        # ### Case-Insensitive Matching
        # Allows completing lowercase inputs as uppercase (e.g., 'doc' -> 'Documents').
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

        # ### Visual Styling
        # Synchronizes completion list colors with the standard LS_COLORS
        # environment variable for a consistent file-browsing experience.
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

        # ### Interactive Navigation
        # Enables a navigable menu (using arrow keys) for selecting
        # completion candidates.
        zstyle ':completion:*' menu select
        zstyle ':completion:*:*:*:*:*' menu select group

        # ### Categorization
        # Formats descriptions above completion groups (e.g., [commands], [files])
        # to improve visual structure in the selection menu.
        zstyle ':completion:*:descriptions' format '[%d]'

        # ### Performance: Caching
        # Enables the completion caching engine. This significantly speeds
        # up completions for heavy commands (like nix packages or large
        # directory trees).
        zstyle ':completion::complete:*' use-cache 1
      '';
    };
  };
}
