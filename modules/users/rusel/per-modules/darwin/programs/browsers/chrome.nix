# =========================================================================
# == SHARED DARWIN MODULE: User Applications (Homebrew Casks)
# This module defines the suite of macOS GUI applications for the
# "rusel" profile. It uses the Homebrew Cask system to manage
# proprietary or complex applications that are not natively available
# in the Nix Store, ensuring a "batteries-included" desktop experience.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Application Registry
  # -----------------------------------------------------------------------
  # We register these applications under the 'rusel' Darwin profile.
  # When the 'maple' host (or any other Mac) imports the 'rusel' profile,
  # these applications will be automatically installed via Homebrew.
  flake.modules.darwin.rusel = {
    homebrew = {
      # ### Homebrew Casks (GUI Apps)
      # Casks are used for macOS applications that come with their own
      # .app bundles, installers, or specific system integrations.
      casks = [
        # #### Google Chrome
        # The primary web browser for development and general use.
        # Managed via Cask to ensure it receives standard macOS updates
        # and integrates correctly with the system's security framework.
        "google-chrome"
      ];
    };
  };
}
