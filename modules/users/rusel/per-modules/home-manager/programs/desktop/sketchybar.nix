# =========================================================================
# == USER PROFILE: rusel (UI Overrides - Sketchybar)
# This module manages the activation state of Sketchybar for the "rusel"
# profile. It provides a definitive override to disable the custom
# status bar, ensuring the user environment remains lightweight or
# relies on standard macOS interface elements.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Environment Registry
  # -----------------------------------------------------------------------
  # We register this override within the 'rusel' Home Manager profile.
  # This demonstrates the power of the Nix module system: we can
  # define a service globally but disable it for a specific user.
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.sketchybar = {
      # ### Explicit Deactivation
      # We use `lib.mkForce false` to ensure that Sketchybar is disabled
      # for this user, regardless of any `mkDefault true` settings in
      # the shared 'programs' or 'services' modules.
      #
      # Reasons for disabling:
      # - Minimalism: Reducing the number of background processes.
      # - Redundancy: Preferring the standard macOS Menu Bar.
      # - Troubleshooting: Isolating UI issues during configuration changes.
      enable = lib.mkForce false;
    };
  };
}
