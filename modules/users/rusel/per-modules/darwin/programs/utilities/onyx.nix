# =========================================================================
# == SHARED DARWIN MODULE: System Maintenance & Optimization (Onyx)
# This module manages the installation of Onyx for the "rusel" profile.
# Onyx is a multi-function utility used to verify the structure of system
# files, run maintenance tasks, and configure hidden parameters of the
# Finder, Dock, Safari, and other Apple applications.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Application Registry
  # -----------------------------------------------------------------------
  # We register Onyx under the 'rusel' Darwin profile. This ensures that
  # any macOS host inheriting this profile has access to advanced
  # system-level diagnostics and "hidden" configuration tweaks.
  flake.modules.darwin.rusel = {
    homebrew = {
      # ### Homebrew Casks (GUI Apps)
      # We use Casks for Onyx because it requires deep system integration,
      # including the ability to run scripts with administrative
      # privileges and access low-level disk utility functions.
      casks = [
        # #### Onyx
        # The definitive maintenance tool for macOS. It allows the user
        # to clear system/application caches, rebuild databases (like
        # Spotlight or LaunchServices), and unlock features that are
        # normally hidden from the standard macOS GUI.
        "onyx"
      ];
    };
  };
}
