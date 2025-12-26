# =========================================================================
# == SHARED DARWIN MODULE: System UI (Menu Bar Clock)
# This module declaratively configures the system clock display. It
# ensures the time is presented in a high-precision, 24-hour format
# with complete date information, providing immediate temporal context
# at a glance.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## System Clock Logic Definition
  # -----------------------------------------------------------------------
  # These settings correspond to the "Date & Time" settings in macOS
  # Control Center. They control the string format and behavior of the
  # clock in the top-right corner of the screen.
  system = {lib, ...}: {
    system.defaults.menuExtraClock = {
      # ### Visual Style
      # Disable blinking separators (the colon between hours and minutes).
      # Keeping this 'false' prevents unnecessary visual movement in the
      # periphery of the user's vision.
      FlashDateSeparators = lib.mkDefault false;

      # Use a digital readout instead of the small analog icon.
      IsAnalog = lib.mkDefault false;

      # ### Time Format
      # Use a 24-hour clock (e.g., 14:00 instead of 2:00 PM). This is the
      # standard for technical environments to avoid AM/PM ambiguity.
      Show24Hour = lib.mkDefault true;

      # Enable the display of seconds for high-precision time tracking.
      ShowSeconds = lib.mkDefault true;

      # ### Date Information
      # Show the current day of the week (e.g., "Fri") and the day of
      # the month (e.g., "26"). This eliminates the need to click the
      # clock to see the date.
      ShowDayOfMonth = lib.mkDefault true;
      ShowDayOfWeek = lib.mkDefault true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the clock defaults into the Darwin registry. This ensures
  # that every workstation provides a consistent, high-information
  # time display.
  flake.modules.darwin = {inherit system;};
}
