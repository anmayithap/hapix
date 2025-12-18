{
  inputs,
  lib,
  ...
}: let
  /**
  * @description Checks if a system string is a Darwin (macOS) system.
  * @param {string} system The system identifier string (e.g., "x86_64-linux" or "aarch64-darwin").
  * @return {boolean} `true` if the system is Darwin, otherwise `false`.
  */
  _isDarwin = system: lib.hasSuffix "darwin" system;

  /**
  * @description Internal helper. Selects the appropriate configuration set
  * (`nixosConfigurations` or `darwinConfigurations`) from the flake's outputs
  * based on the system type. This lets `hostsBySystem` search only in the
  * relevant location.
  * @param {string} system The target system identifier.
  * @param {object} self The current flake's self object (`inputs.self`).
  * @return {attrset} Either `self.darwinConfigurations` or `self.nixosConfigurations`.
  */
  _systemPredicate = system: self:
    if _isDarwin system
    then self.darwinConfigurations
    else self.nixosConfigurations;
in {
  flake = {
    /**
    * @description A library of helper functions for this flake.
    */
    lib = {
      /**
      * @description A utility to find all hosts (NixOS or Darwin configurations)
      * that are built for a specific system architecture.
      *
      * It scans the flake's `nixosConfigurations` and `darwinConfigurations` and returns
      * a list of host names whose `config.nixpkgs.hostPlatform.system`
      * matches the provided argument.
      *
      * @param {string} system The system identifier string to find hosts for
      * (e.g., "x86_64-linux" or "aarch64-darwin").
      *
      * @return {list-of-strings} A list of host names that match the specified system.
      *
      * @example
      *   # Assuming you have a flake structure like this:
      *   # nixosConfigurations = {
      *   #   server1 = nixpkgs.lib.nixosSystem { system = "x86_64-linux"; ... };
      *   #   server2 = nixpkgs.lib.nixosSystem { system = "aarch64-linux"; ... };
      *   # };
      *   # darwinConfigurations = {
      *   #   my-mac = nixpkgs.lib.darwinSystem { system = "aarch64-darwin"; ... };
      *   # };
      *
      *   self.lib.hostsBySystem "x86_64-linux"
      *   # => [ "server1" ]
      *
      *   self.lib.hostsBySystem "aarch64-darwin"
      *   # => [ "my-mac" ]
      */
      hostsBySystem = system: let
        # Get access to the current flake's outputs.
        inherit (inputs) self;

        # Determine where to look for hosts: in `nixosConfigurations` or `darwinConfigurations`.
        where = _systemPredicate system self;

        # Filter the attributes (hosts) in the selected set, keeping only those
        # whose system matches the requested one.
        _system = lib.filterAttrs (_: value: value.config.nixpkgs.hostPlatform.system == system) where;
      in
        # Return only the names (keys) of the filtered hosts.
        lib.attrNames _system;
    };
  };
}
