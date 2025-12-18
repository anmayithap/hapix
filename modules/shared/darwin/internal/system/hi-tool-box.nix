_: let
  system = {lib, ...}: {
    system.defaults.hitoolbox = {
      AppleFnUsageType = lib.mkDefault "Change Input Source";
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
