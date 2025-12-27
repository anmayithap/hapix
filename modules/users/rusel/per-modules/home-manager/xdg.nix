# =========================================================================
# == USER PROFILE: rusel (XDG & Clean Home Environment)
# This module enforces the XDG Base Directory Specification across all
# platforms. It prioritizes a clean and organized home directory by
# redirecting application-specific files to standardized locations
# (~/.config, ~/.local/share, etc.), ensuring consistency between
# macOS and Linux environments.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Environment Registry
  # -----------------------------------------------------------------------
  # We register these settings within the 'rusel' Home Manager profile.
  # This ensures that regardless of the host OS, the user's environment
  # follows a modern, organized file structure.
  flake.modules.homeManager.rusel = {lib, ...}: {
    # ### XDG Base Directory Management
    # Formally enables the management of XDG directories.
    #
    # On macOS, where XDG is not a native standard, this is particularly
    # useful as it forces cross-platform CLI tools (like git, neovim,
    # and various languages) to behave predictably and store their
    # configs in ~/.config.
    xdg.enable = lib.mkForce true;

    # ### Clean Home Philosophy
    # When enabled, Home Manager attempts to move standard "legacy"
    # directories into XDG-compliant locations.
    #
    # For example, it will try to place:
    # - .ssh into ~/.config/ssh (if supported)
    # - .gnupg into ~/.local/share/gnupg
    #
    # This significantly reduces the number of hidden files at the
    # root of $HOME, making the filesystem easier to navigate and
    # backup.
    home.preferXdgDirectories = lib.mkForce true;
  };
}
