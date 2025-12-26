# =========================================================================
# == SHARED MODULE: Time & Localization
# This module defines the temporal environment for the system. It ensures
# that the system clock and all time-dependent services operate within
# a consistent timezone, providing a reliable baseline for logging,
# scheduling, and multi-platform synchronization.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Time Logic Definition
  # -----------------------------------------------------------------------
  # We establish a global timezone policy. For personal workstations and
  # servers, keeping a unified timezone is critical for interpreting
  # logs and understanding system events in a chronological context.
  time = {lib, ...}: {
    time = {
      # ### System Timezone
      # Sets the timezone to 'Europe/Moscow'.
      #
      # We use `lib.mkDefault` to allow for geographical flexibility.
      # While this serves as the primary home-base setting, a portable
      # host (like a laptop used for travel) can easily override this
      # in its specific configuration using `lib.mkForce` or by simply
      # providing a more specific value.
      timeZone = lib.mkDefault "Europe/Moscow";
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection (Cross-Platform)
  # -----------------------------------------------------------------------
  # Registers the time configuration into both the Darwin and NixOS
  # registries. This ensures that whether the host is a Mac or a
  # Linux machine, the temporal context remains identical.
  flake.modules = {
    # macOS Time Registry
    darwin.time = time;

    # NixOS Time Registry
    nixos.time = time;
  };
}
