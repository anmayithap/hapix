# =========================================================================
# == SHARED DARWIN MODULE: System Maintenance (Software Updates)
# This module defines the update policy for the macOS operating system.
# It prioritizes system stability and user control by disabling automatic
# background installations of major macOS updates.
# =========================================================================
let
  # -----------------------------------------------------------------------
  # ## Software Update Logic Definition
  # -----------------------------------------------------------------------
  # These settings control the behavior of the "Software Update" engine
  # found in macOS System Settings.
  system = {lib, ...}: {
    system.defaults.SoftwareUpdate = {
      # ### Automatic Installation
      # We disable the automatic installation of macOS updates.
      #
      # In a declarative Nix environment, stability is paramount.
      # Automatically applying OS updates can lead to unexpected
      # restarts or breaking changes in system APIs that nix-darwin
      # relies on. By setting this to 'false', we ensure that the user
      # can vet and trigger updates manually at a convenient time.
      AutomaticallyInstallMacOSUpdates = lib.mkDefault false;
    };
  };
in {
  # -----------------------------------------------------------------------
  # ## Module Registry Injection
  # -----------------------------------------------------------------------
  # Registers the software update defaults into the Darwin registry.
  # This serves as a protective layer, ensuring that managed hosts
  # do not change their underlying OS version without explicit consent.
  flake.modules.darwin = {
    inherit system;
  };
}
