_: let
  system = {lib, ...}: {
    system.defaults.ActivityMonitor = {
      OpenMainWindow = lib.mkDefault true;
      ShowCategory = lib.mkDefault 101; # All Processes, Hierarchally
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
