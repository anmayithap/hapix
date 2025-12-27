# =========================================================================
# == USER PROFILE: rusel (User Font Configuration)
# This module configures the Fontconfig utility for the user environment.
# It ensures that fonts installed via Home Manager are properly
# discovered by applications, providing a consistent typographic
# experience in the terminal, editors, and GUI tools.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Environment Registry
  # -----------------------------------------------------------------------
  # We register this configuration within the 'rusel' Home Manager profile.
  # This serves as the bridge between the system's font packages and
  # the user's specific application requirements.
  flake.modules.homeManager.rusel = {lib, ...}: {
    # ### Fontconfig Orchestration
    # Fontconfig is the standard library used by many applications (like
    # Alacritty, Ghostty, VS Code, and various CLI tools) to discover
    # and render fonts.
    fonts.fontconfig = {
      # ### Activation
      # We force-enable Fontconfig management.
      #
      # On macOS (Darwin), where font management is natively handled
      # by the OS, enabling this through Home Manager is crucial for
      # Nix-installed applications to "see" fonts located in the
      # Nix store or the user's profile (~/.nix-profile/share/fonts).
      #
      # Using `lib.mkForce` ensures that this discovery mechanism is
      # always active, overriding any default system-level omissions.
      enable = lib.mkForce true;
    };
  };
}
