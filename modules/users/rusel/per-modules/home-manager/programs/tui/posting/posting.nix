# =========================================================================
# == USER PROFILE: rusel (API Client - Posting)
# This module integrates 'posting' into the user environment. Posting is
# a modern, terminal-based HTTP client (TUI) that provides a functional
# and efficient alternative to Postman or Insomnia for API debugging
# and development directly within the CLI.
# =========================================================================
{
  flake.modules.homeManager.rusel = {pkgs, ...}: {
    # -----------------------------------------------------------------------
    # ## User Packages
    # -----------------------------------------------------------------------
    home.packages = with pkgs; [
      # ### Posting (HTTP TUI)
      # A powerful "Postman-style" terminal interface.
      #
      # Key features:
      # - Persistent collections and environments.
      # - Native keyboard-driven workflow.
      # - Support for advanced request types, headers, and bodies.
      #
      # Installing this via 'home.packages' ensures it is available in
      # the user's PATH across both macOS and Linux environments.
      posting
    ];
  };
}
