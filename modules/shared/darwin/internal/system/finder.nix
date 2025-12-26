# =========================================================================
# == SHARED DARWIN MODULE: System (Finder)
# This module optimizes the macOS Finder for a developer-centric workflow.
# It prioritizes navigational transparency (showing hidden files and
# extensions), breadcrumb visibility (path and status bars), and a
# minimalist, icon-free desktop.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Finder Logic Definition
  # -----------------------------------------------------------------------
  system = {lib, ...}: {
    system.defaults.finder = {
      # ### File Visibility
      # Always show file extensions (e.g., .js, .sh). This is critical
      # for security and development to avoid ambiguity.
      AppleShowAllExtensions = lib.mkDefault true;

      # Show hidden files and "dotfiles" (e.g., .git, .ssh).
      AppleShowAllFiles = lib.mkDefault true;

      # ### Desktop Minimalism
      # Disable the rendering of icons on the desktop. This encourages a
      # clean workspace and the use of the file system or launchers.
      CreateDesktop = lib.mkDefault false;

      # Hide physical drives and network shares from the desktop.
      # These remain accessible via the Finder sidebar.
      ShowExternalHardDrivesOnDesktop = lib.mkDefault false;
      ShowHardDrivesOnDesktop = lib.mkDefault false;
      ShowMountedServersOnDesktop = lib.mkDefault false;
      ShowRemovableMediaOnDesktop = lib.mkDefault false;

      # ### Navigation & View Style
      # Set the default view to 'Column View' (clmv). This is widely
      # considered the most efficient view for deeply nested directories.
      FXPreferredViewStyle = lib.mkDefault "clmv";

      # Open new Finder windows at the user's Home directory (~/)
      # instead of the "Recents" view.
      NewWindowTarget = lib.mkDefault "Home";

      # Keep folders on top when sorting by name (Windows/Linux style).
      _FXSortFoldersFirst = lib.mkDefault true;

      # ### Search & Maintenance
      # Default search scope: Search within the current folder ("SCev")
      # rather than the entire Mac.
      FXDefaultSearchScope = lib.mkDefault "SCev";

      # Automatically empty the trash after items have been there for 30 days.
      FXRemoveOldTrashItems = lib.mkDefault true;

      # Warn when changing a file extension to prevent accidental
      # format changes.
      FXEnableExtensionChangeWarning = lib.mkDefault true;

      # ### UI Breadcrumbs
      # Show the path bar at the bottom, allowing for quick "jump-back"
      # navigation.
      ShowPathbar = lib.mkDefault true;

      # Show the status bar (item count and storage space information).
      ShowStatusBar = lib.mkDefault true;

      # Show the full POSIX path in the window title bar. Useful for
      # distinguishing between folders with the same name in different paths.
      _FXShowPosixPathInTitle = lib.mkDefault true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the Finder defaults into the Darwin registry. This
  # configuration ensures that any Mac host in this flake behaves like
  # a professional workstation by default.
  flake.modules.darwin = {inherit system;};
}
