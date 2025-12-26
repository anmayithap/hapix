# =========================================================================
# == SHARED DARWIN MODULE: Power Management (Sleep)
# This module defines the power-saving policies for macOS systems. It
# configures how long the machine should wait during inactivity before
# putting the computer, the display, or the hard disks to sleep.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Power Logic Definition
  # -----------------------------------------------------------------------
  # We define power settings as a standard module function. These settings
  # correspond to the "Energy Saver" or "Battery & Lock Screen"
  # preferences in macOS System Settings.
  power = {lib, ...}: {
    power = {
      sleep = {
        # ### Computer Sleep
        # The number of minutes of idle time before the entire system
        # enters sleep mode. We set a baseline of 20 minutes.
        computer = lib.mkDefault 20;

        # ### Display Sleep
        # The number of minutes before the display is turned off.
        # Note: If this is longer than computer sleep, the computer
        # sleep timer usually takes precedence.
        display = lib.mkDefault 30;

        # ### Hard Disk Sleep
        # Idle time in minutes before the system spins down internal
        # hard disks. While less critical for SSDs, this remains a
        # standard macOS power management parameter.
        harddisk = lib.mkDefault 30;
      };
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # By injecting this into `flake.modules.darwin`, we make the 'power'
  # component available to our host factory. This allows all Darwin
  # hosts to inherit these energy-saving defaults automatically.
  flake.modules.darwin = {inherit power;};
}
