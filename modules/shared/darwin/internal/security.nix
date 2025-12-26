# =========================================================================
# == SHARED DARWIN MODULE: Security (PAM & Authentication)
# This module configures Pluggable Authentication Modules (PAM) for macOS.
# It enables seamless biometric authentication for administrative tasks
# in the terminal and fixes session persistence issues for power users
# working within terminal multiplexers.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Security Logic Definition
  # -----------------------------------------------------------------------
  # We define security settings as a standard module function. These
  # settings modify the underlying PAM stack used by the 'sudo' command.
  security = {lib, ...}: {
    security.pam.services.sudo_local = {
      # ### Touch ID Authentication
      # Enable the use of Touch ID for 'sudo' commands in the terminal.
      # This allows you to authenticate administrative actions with a
      # fingerprint rather than typing your password, significantly
      # improving ergonomics without compromising security.
      touchIdAuth = lib.mkDefault true;

      # ### PAM Session Reattachment
      # Fixes an issue where Touch ID authentication fails within terminal
      # multiplexers like 'tmux' or 'screen'.
      #
      # By setting 'reattach' to true, nix-darwin ensures that the
      # security context is correctly preserved across different shell
      # sessions, making biometric sudo reliable for advanced CLI workflows.
      reattach = lib.mkDefault true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the PAM security defaults into the Darwin registry.
  # This provides a modern, biometric-first security baseline for
  # all managed macOS workstations.
  flake.modules.darwin = {
    inherit security;
  };
}
