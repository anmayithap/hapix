# =========================================================================
# == SHARED LIBRARY: Host Discovery (hosts-by-system)
# This module provides utility functions to inspect the flake's own
# configurations. It allows for the dynamic discovery of hosts based on
# their target architecture, enabling cross-platform automation and
# better visibility into the flake's infrastructure.
# =========================================================================
{
  inputs,
  lib,
  ...
}: let
  # -----------------------------------------------------------------------
  # ## Internal Helpers
  # -----------------------------------------------------------------------
  /**
  * _isDarwin
  *
  * Identifies if a system string belongs to the macOS family.
  * Logic: Checks if the system identifier ends with "darwin".
  */
  _isDarwin = system: lib.hasSuffix "darwin" system;

  /**
  * _systemPredicate
  *
  * Acts as a router to select the correct configuration set from the
  * flake's outputs. It ensures that we only search for hosts in the
  * relevant attribute set (nixosConfigurations vs darwinConfigurations).
  */
  _systemPredicate = system: self:
    if _isDarwin system
    then self.darwinConfigurations
    else self.nixosConfigurations;
in {
  flake = {
    # -----------------------------------------------------------------------
    # ## Public Library Functions
    # -----------------------------------------------------------------------
    lib = {
      /**
      * hostsBySystem
      *
      * A powerful utility to retrieve a list of hostnames matching a
      * specific architecture.
      *
      * # How it works:
      * 1. It identifies the platform type (Linux/Darwin).
      * 2. It iterates over the corresponding configuration set.
      * 3. It inspects the `nixpkgs.hostPlatform.system` of each host.
      * 4. It returns the keys (names) of matching hosts.
      *
      * # Inputs:
      * `system` (string): The architecture string (e.g., "aarch64-darwin").
      *
      * # Example Usage:
      *   self.lib.hostsBySystem "aarch64-darwin"
      *   => [ "maple" ]
      */
      hostsBySystem = system: let
        # Access the current flake's outputs (self).
        inherit (inputs) self;

        # Determine the search scope based on the architecture type.
        where = _systemPredicate system self;

        # Filter the hosts by comparing their internal platform
        # configuration with the requested system string.
        _system =
          lib.filterAttrs (
            _: value:
              value.config.nixpkgs.hostPlatform.system == system
          )
          where;
      in
        # Return the list of hostnames (keys).
        lib.attrNames _system;
    };
  };
}
