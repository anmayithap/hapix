# =========================================================================
# == SHARED DARWIN MODULE: Internal Networking (Firewall)
# This module provides a standardized configuration for the macOS
# Application Firewall. It is designed as an internal component that
# can be inherited by broader profiles (like 'rusel') to ensure a
# secure-by-default network posture.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Networking Module Definition
  # -----------------------------------------------------------------------
  # We define the firewall settings as a standard NixOS/Darwin module
  # function. This allows us to pass 'lib' and other arguments during
  # the final system evaluation.
  networking = {lib, ...}: {
    networking.applicationFirewall = {
      # ### Firewall Activation
      # We enable the macOS Application Firewall by default.
      enable = lib.mkDefault true;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # We register this specific networking logic into the global flake
  # module registry. By placing it under `flake.modules.darwin`, it
  # becomes available for host configurations (like 'maple') to
  # import via `inputs.self.modules.darwin.networking`.

  flake.modules.darwin = {inherit networking;};
}
