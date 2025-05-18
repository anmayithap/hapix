/*
Common tools for the entire project.
*/
{
  nixpkgs,
  available-systems,
}: let
  system-detection-tools = import ./system-detection.nix {
    inherit nixpkgs;
  };

  system-apply-tools = import ./system-apply.nix {
    inherit nixpkgs available-systems;
  };

  path-tools = import ./path.nix {
    inherit nixpkgs;
  };
in {
  inherit (system-detection-tools) isDarwinBySystemName isLinuxBySystemName;
  inherit (system-apply-tools) pkgsForSystem forAllSystems;
  inherit (path-tools) scanPaths;
}
