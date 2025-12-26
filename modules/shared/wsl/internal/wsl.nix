# =========================================================================
# == SHARED NIXOS MODULE: WSL Integration (Internal)
# This module provides the primary activation switch for NixOS-WSL.
# It serves as a foundational component that, when enabled, triggers
# the specialized logic required for NixOS to function seamlessly as
# a guest within the Windows Subsystem for Linux environment.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## WSL Activation Logic
  # -----------------------------------------------------------------------
  # This logic targets the 'wsl' namespace provided by the NixOS-WSL
  # community module.
  wsl = {lib, ...}: {
    wsl = {
      # ### Enable WSL Integration
      # Setting this to 'true' activates the specialized init system,
      # kernel configurations, and Windows interoperability features
      # (such as auto-mounting Windows drives and path sharing).
      #
      # We use `lib.mkDefault` to ensure that while this is the standard
      # for WSL-targeted hosts, it remains overrideable for specialized
      # test environments or custom builds.
      enable = lib.mkDefault true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the WSL activation module into the NixOS registry.
  # This component is a mandatory dependency for the 'nixos.wsl' profile,
  # ensuring that any host identified as a WSL instance is correctly
  # initialized.
  flake.modules.nixos = {
    inherit wsl;
  };
}
