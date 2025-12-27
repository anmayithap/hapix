# =========================================================================
# == USER PROFILE: rusel (Messaging & Communication)
# This module manages communication software for the "rusel" profile.
# It leverages Homebrew Casks to ensure that GUI-based messaging platforms
# are installed declaratively and kept up to date across all Darwin hosts.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Communication Registry
  # -----------------------------------------------------------------------
  # We register these tools under the 'rusel' Darwin profile. This ensures
  # that your communication stack is automatically deployed whenever
  # this profile is imported by a macOS host (like 'maple').
  flake.modules.darwin.rusel = {
    homebrew = {
      # ### Homebrew Casks (GUI Apps)
      # We use Casks for Telegram to handle the .app bundle and its
      # specific macOS system integrations (like notifications and
      # background refresh) natively.
      casks = [
        # #### Telegram
        # The primary messaging client for real-time communication.
        # Using the Cask version ensures the application is correctly
        # placed in /Applications and integrates with the macOS
        # security and notification systems.
        "telegram"
      ];
    };
  };
}
