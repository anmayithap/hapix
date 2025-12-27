# =========================================================================
# == USER PROFILE: rusel (Terminal Interaction - Alacritty)
# This module integrates the Alacritty terminal emulator with the global
# hotkey daemon (skhd). It establishes a dedicated keyboard shortcut for
# rapid terminal access, improving workflow efficiency on macOS.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## Hotkey Integration
  # -----------------------------------------------------------------------
  # We extend the 'rusel' Home Manager profile. This module provides the
  # "glue" between the terminal application and the input daemon.
  flake.modules.homeManager.rusel = {lib, ...}: {
    services.skhd = {
      # ### Configuration Merging
      # Using 'lib.mkAfter' ensures this shortcut is appended to the
      # global skhd configuration without overwriting existing bindings.
      config = lib.mkAfter ''

        # -------------------------------------------------------------------
        # #### Terminal Launcher
        # -------------------------------------------------------------------

        # Open Alacritty
        # Shortcut: Left Command + Left Option + T
        # Action: Launches Alacritty or brings it to the foreground if
        # it is already running.
        lcmd + lalt - t : open -a Alacritty

      '';
    };
  };
}
