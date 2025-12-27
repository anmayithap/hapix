# =========================================================================
# == SHARED DARWIN MODULE: User Applications (VPN Client)
# This module manages the installation of Tunnelblick for the "rusel"
# profile. Tunnelblick is a specialized OpenVPN GUI for macOS, serving
# as the primary interface for managing and activating the encrypted
# VPN profiles (.ovpn) defined in our secrets library.
# =========================================================================
{
  # -----------------------------------------------------------------------
  # ## User Application Registry
  # -----------------------------------------------------------------------
  # We register Tunnelblick under the 'rusel' Darwin profile. This ensures
  # that all macOS hosts managed by this flake have a consistent and
  # reliable way to establish secure network connections.
  flake.modules.darwin.rusel = {
    homebrew = {
      # ### Homebrew Casks (GUI Apps)
      # We use Casks for Tunnelblick because it requires specific kernel
      # extensions (kexts) and system-level networking permissions that
      # are most reliably managed through the Homebrew installer on macOS.
      casks = [
        # #### Tunnelblick
        # A free, open-source graphic user interface for OpenVPN on macOS.
        # It handles the complex task of managing VPN routes and
        # DNS settings, providing a seamless bridge between the OS
        # and our declarative .ovpn configurations.
        "tunnelblick"
      ];
    };
  };
}
