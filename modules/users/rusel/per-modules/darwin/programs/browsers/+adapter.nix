# =========================================================================
# == USER PROFILE: rusel (skhd Keybindings)
# This module defines personalized keyboard shortcuts for the "rusel"
# user. It integrates with the shared 'skhd' service, allowing for
# rapid application launching and system navigation through custom
# hotkey combinations.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Hotkey Registry
  # -----------------------------------------------------------------------
  # We extend the 'rusel' Home Manager profile. Since 'skhd' is managed
  # as a service, these changes will automatically trigger a daemon
  # reload upon system activation.
  flake.modules.homeManager.rusel = {lib, ...}: {
    services.skhd = {
      # ### Configuration Merging
      # We use `lib.mkAfter` to append these shortcuts to the end of the
      # configuration file.
      #
      # Recall that our shared 'skhd' module initialized the config with
      # 'lib.mkBefore ""'. This pattern allows us to define "global"
      # shortcuts in one module and "user" or "app" shortcuts here
      # without any risk of collision.
      config = lib.mkAfter ''

        # -------------------------------------------------------------------
        # #### Application Launchers
        # -------------------------------------------------------------------

        # Open Google Chrome
        # Shortcut: Left Command + Left Option + B
        # Action: Launches Google Chrome or focuses it if already running.
        lcmd + lalt - b : open -a Google\ Chrome

      '';
    };
  };
}
