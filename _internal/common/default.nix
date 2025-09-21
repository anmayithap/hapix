/*
Common tools for the entire project.
*/
{lib}: let
  # Evaluate system detection tools.
  # This module provide function to detect current system.
  system-detection-tools = import ./system-detection.nix {
    inherit lib;
  };

  # Evaluate system apply tools.
  # This module provide functions to apply attrs by system.
  system-apply-tools = import ./system-apply.nix {
    inherit lib;
  };

  # Evaluate path tools.
  # This module provide functions to work with paths.
  path-tools = import ./path.nix {
    inherit lib;
  };
in {
  inherit (system-detection-tools) isDarwinBySystemName isLinuxBySystemName;
  inherit (system-apply-tools) pkgsForSystem;
  inherit (path-tools) scanPaths relativeToRoot;
}
