/*
Common tools for the entire project.
*/
{
  lib,
  haumea,
}: let
  # Evaluate system detection tools.
  # This module provide function to detect current system.
  system-detection-tools = haumea.lib.load {
    src = ./system-detection.nix;
    inputs = {
      inherit lib;
    };
  };

  # Evaluate system apply tools.
  # This module provide functions to apply attrs by system.
  system-apply-tools = haumea.lib.load {
    src = ./system-apply.nix;
    inputs = {
      inherit lib;
    };
  };

  # Evaluate path tools.
  # This module provide functions to work with paths.
  path-tools = haumea.lib.load {
    src = ./path.nix;
    inputs = {
      inherit lib;
    };
  };
in {
  inherit (system-detection-tools) isDarwinBySystemName isLinuxBySystemName;
  inherit (system-apply-tools) pkgsForSystem;
  inherit (path-tools) scanPaths;
}
