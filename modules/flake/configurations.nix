# =========================================================================
# == CONFIGURATIONS: System-level entry points for NixOS and macOS
# This module defines which hosts belong to this flake. It uses a custom
# factory (mkDarwin / mkLinux / mkLinuxWSL) to maintain a DRY
# configuration across multiple machines.
# =========================================================================
{inputs, ...}: let
  # Extract custom configuration factory from the local library.
  inherit (inputs.self.lib.conf-factory) mkDarwin;
in {
  flake = {
    # -----------------------------------------------------------------------
    # ## NixOS Configurations (Linux)
    # -----------------------------------------------------------------------
    # This attribute set defines Linux-based systems.
    nixosConfigurations = {
      # example-linux-host = mkLinux "example-host";
      # example-wsl-host = mkLinuxWSL "example-wsl-host";
    };

    # -----------------------------------------------------------------------
    # ## Darwin Configurations (macOS)
    # -----------------------------------------------------------------------
    # This attribute set defines macOS systems managed via nix-darwin.
    darwinConfigurations = {
      maple = mkDarwin "maple";
    };
  };
}
