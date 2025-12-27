# =========================================================================
# == USER PROFILE: rusel (Search Engine - fd)
# This module configures 'fd', a fast and user-friendly alternative to
# the traditional 'find' command. It optimizes search behavior for
# developer workflows by enabling hidden file discovery while
# maintaining strict exclusion of version control internals.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.fd = {
      # ### Core Activation
      # Force-enable fd as the primary filesystem search backend.
      # Using 'lib.mkForce' ensures that its optimized behavior is
      # consistently available across all platforms in the "rusel" profile.
      enable = lib.mkForce true;

      # ### Search Scope (Hidden Files)
      # By setting 'hidden' to true, fd will search through dotfiles
      # and hidden directories (e.g., .config, .ssh). This is essential
      # for managing Nix configurations and dotfiles.
      hidden = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Behavioral Options
      # -----------------------------------------------------------------------
      # We use 'lib.mkBefore' to establish these foundational flags.
      # These settings directly influence how paths are rendered and
      # how symbolic links are handled.
      extraOptions = lib.mkBefore [
        # #### Output Formatting
        # Removes the './' prefix from search results in the current
        # directory, resulting in cleaner paths for piping into
        # other commands or FZF.
        "--strip-cwd-prefix"

        # #### Link Traversal
        # Instructs fd to follow symbolic links. This ensures that
        # linked directories (common in Nix-managed homes) are
        # transparently included in search results.
        "--follow"

        # #### Strict Exclusions
        # Even though 'hidden' is enabled, we explicitly exclude the
        # '.git' directory. This prevents search clutter from internal
        # object databases and improves performance in large repositories.
        "--exclude .git"
      ];
    };
  };
}
