# =========================================================================
# == SHARED HOME-MANAGER MODULE: skhd (Simple Hotkey Daemon)
# This module configures skhd, a modal hotkey daemon for macOS. It
# serves as the primary input handler for window management (yabai),
# application launching, and system utilities, providing a highly
# responsive, keyboard-driven workflow.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## skhd Logic Definition
  # -----------------------------------------------------------------------
  # We define the daemon settings as a standard Home Manager module.
  # skhd works by listening for keyboard events and executing shell
  # commands in response to specific key combinations.
  services = {lib, ...}: {
    services.skhd = {
      # ### Activation
      # Enable the skhd service. When active, Home Manager will manage
      # the associated LaunchAgent to ensure the daemon starts
      # automatically upon login.
      enable = lib.mkDefault true;

      # ### Configuration Skeleton
      # We initialize the configuration with an empty string using
      # `lib.mkBefore`.
      #
      # This is a strategic architectural choice: it creates a "base layer"
      # for the config file. Other modules (e.g., a window manager module
      # or an apps module) can then use `lib.mkAfter` or standard strings
      # to append their specific shortcuts without overwriting the
      # entire file.
      config = lib.mkBefore '''';
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the skhd service into the Home Manager registry. This
  # allows your user profiles to inherit a consistent keyboard-driven
  # interface across all Darwin workstations.
  flake.modules.homeManager = {
    inherit services;
  };
}
