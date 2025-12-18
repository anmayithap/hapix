_: let
  system = {lib, ...}: {
    system.defaults.SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = lib.mkDefault false;
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
