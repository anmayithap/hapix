# =========================================================================
# == SHARED DARWIN MODULE: System UI (Login Window & Security)
# This module declaratively manages the macOS login screen. It ensures
# that hardware power actions remain accessible to the user while
# hardening the system by disabling unauthenticated guest access.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Login Window Logic Definition
  # -----------------------------------------------------------------------
  # These settings control the "lock screen" before a user session
  # is established.
  system = {lib, ...}: {
    system.defaults.loginwindow = {
      # ### Access Control
      # Disables the "Guest" account. This is a primary security hardening
      # measure, ensuring that only users with valid, local credentials
      # can access the machine.
      GuestEnabled = lib.mkDefault false;

      # ### Power Actions
      # We ensure that Sleep, Restart, and Shut Down options are always
      # available at the login screen. This prevents situations where
      # a user might be "trapped" at the login screen without a way to
      # safely manage the hardware state.
      SleepDisabled = lib.mkDefault false;
      ShutDownDisabled = lib.mkDefault false;
      RestartDisabled = lib.mkDefault false;

      # These settings ensure that even if a session is active (e.g.,
      # switched users), the physical power actions remain functional.
      RestartDisabledWhileLoggedIn = lib.mkDefault false;
      ShutDownDisabledWhileLoggedIn = lib.mkDefault false;
      PowerOffDisabledWhileLoggedIn = lib.mkDefault false;

      # ### Visual Style
      # When set to 'false', macOS shows a list of users (avatars/names).
      # When set to 'true', it shows two empty text fields for "Name" and
      # "Password". We default to the user list for a smoother UX.
      SHOWFULLNAME = lib.mkDefault false;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the login window defaults into the Darwin registry.
  # This provides a consistent and secure entry point across all
  # managed Apple hardware.
  flake.modules.darwin = {inherit system;};
}
