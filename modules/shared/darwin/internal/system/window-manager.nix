# =========================================================================
# == SHARED DARWIN MODULE: Window Management & Stage Manager
# This module defines the behavior of the macOS windowing engine. It
# configures Stage Manager settings and desktop visibility, ensuring a
# minimalist workspace where desktop icons are suppressed in favor of
# a clean wallpaper, while keeping traditional window management active.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Window Manager Logic Definition
  # -----------------------------------------------------------------------
  # These settings correspond to the "Desktop & Dock" section in macOS
  # System Settings, specifically the Stage Manager and Widgets behaviors.
  system = {lib, ...}: {
    system.defaults.WindowManager = {
      # ### Stage Manager Configuration
      # We disable Stage Manager globally. This is often preferred by
      # power users who rely on Mission Control, classic Command+Tab,
      # or third-party tiling window managers (like Yabai or Aerospace).
      GloballyEnabled = lib.mkDefault false;

      # If Stage Manager were enabled, this would group windows from the
      # same application together in the side strip.
      AppWindowGroupingBehavior = lib.mkDefault true;

      # Prevent the Stage Manager strip from auto-hiding.
      AutoHide = lib.mkDefault false;

      # ### Desktop & Widgets
      # Enforce a clean desktop by hiding all files and icons. This
      # complements the 'Finder' module's 'CreateDesktop = false' setting
      # to ensure the wallpaper remains unobstructed.
      HideDesktop = lib.mkDefault true;
      StandardHideDesktopIcons = lib.mkDefault true;

      # ### Widget Visibility
      # We keep widgets visible on the desktop and within Stage Manager.
      # This allows for "passive" information (like calendars or weather)
      # to remain accessible on the wallpaper even when icons are hidden.
      StageManagerHideWidgets = lib.mkDefault false;
      StandardHideWidgets = lib.mkDefault false;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the Window Manager defaults into the Darwin registry.
  # This ensures that every managed host maintains a consistent
  # spatial and organizational "feel" for windows and the desktop.
  flake.modules.darwin = {
    inherit system;
  };
}
