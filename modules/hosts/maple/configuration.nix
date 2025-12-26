# =========================================================================
# == HOST CONFIGURATION: maple (macOS)
# This module defines the unique identity of the "maple" system. It
# registers the host's configuration within the flake's module registry,
# combining shared Darwin modules with host-specific hardware or
# networking settings.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Module Registration
  # -----------------------------------------------------------------------
  # We register this host under `flake.modules.darwin.maple`. This allows
  # our configuration factory (e.g., mkDarwin) to easily find and
  # initialize this specific machine by name.
  flake.modules.darwin.maple.imports = with inputs.self.modules.darwin; [
    # ### Base Profile
    # `rusel` is a shared Darwin profile defined in our library/modules.
    # It likely contains common macOS settings, applications, and
    # system-level defaults used across all our Mac machines.
    rusel

    # -----------------------------------------------------------------------
    # ## Machine Identity (Networking)
    # -----------------------------------------------------------------------
    # macOS has several layers of naming. We align them all to "maple"
    # to ensure consistency across the terminal, local network discovery,
    # and the GUI.
    {
      # The standard Unix hostname used in the shell and by system services.
      networking.hostName = "maple";

      # Used by mDNS (Bonjour). This is how the Mac appears as "maple.local"
      # to other devices on the network.
      networking.localHostName = "maple";

      # The user-visible name shown in the "About This Mac" section
      # and in the Finder sidebar
      networking.computerName = "maple";
    }
  ];
}
