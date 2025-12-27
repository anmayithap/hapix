# =========================================================================
# == USER PROFILE: rusel (Directory Listing - eza)
# This module configures 'eza', a modern, feature-rich replacement for the
# 'ls' command. It prioritizes high-information density through Nerd Font
# icons, Git status integration, and intelligent file grouping.
# =========================================================================
{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.eza = {
      # ### Core Activation
      # Force-enable eza as the primary directory listing utility.
      enable = lib.mkForce true;

      # ### Appearance & Icons
      # Enforce colorized output for better visual distinction of file types.
      colors = lib.mkForce "always";

      # Automatically detect Nerd Font support to render icons next to
      # file names, improving rapid visual identification.
      icons = lib.mkForce "auto";

      # ### Version Control Integration
      # Enable Git status indicators in the listing. This shows whether
      # files are modified, staged, or new directly within the 'ls' output.
      git = lib.mkForce true;

      # -----------------------------------------------------------------------
      # ## Behavioral Options
      # -----------------------------------------------------------------------
      # We use 'lib.mkBefore' to establish these fundamental flags as
      # the default behavior for the 'rusel' profile.
      extraOptions = lib.mkBefore [
        # "-A": Almost-all. Show hidden files but exclude '.' and '..'.
        "-A"

        # "-F": Classify. Append indicators (like / for dirs) to entries.
        "-F"

        # Group directories at the top of the list for cleaner navigation.
        "--group-directories-first"

        # Sort entries by file extension to group similar file types together.
        "--sort=extension"
      ];
    };
  };
}
