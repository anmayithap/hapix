{inputs, ...}: let
  inherit
    (inputs.self.lib.conf-factory)
    mkDarwin
    ;
in {
  flake = {
    nixosConfigurations = {};

    darwinConfigurations = {
      maple = mkDarwin "maple";
    };
  };
}
