# =========================================================================
# == SHARED LIBRARY: Home Factory (home-factory)
# This module defines the high-level "factory" used to instantiate
# home manager.
# =========================================================================
{pkgs, ...}: let
  # -----------------------------------------------------------------------
  # ## Home Directory Factory
  # -----------------------------------------------------------------------
  # A decorator that produces path to the home directory.
  # Params:
  # - `username`: The specific username (e.g., "rusel").
  mkHomeDirectory = username:
    if pkgs.stdenvNoCC.isDarwin
    then "/Users/${username}"
    else "/home/${username}";
in {
  # -----------------------------------------------------------------------
  # ## Library Export
  # -----------------------------------------------------------------------
  # We expose the factory under the 'flake.lib' attribute. This allows
  # our 'flake/configurations.nix' to call these functions to define
  # the actual outputs of the flake.
  flake = {
    lib = {
      home-factory = {
        inherit mkHomeDirectory;
      };
    };
  };
}
