_: let
  module = {
    lib,
    config,
    ...
  }: let
    inherit (config.user-meta) username;
    inherit (config.user-meta) homeDirectory;
  in {
    system = {
      primaryUser = lib.mkDefault username;
      defaults = {
        dock = {
          persistent-others = lib.mkDefault [
            "${homeDirectory}/dev"
            "${homeDirectory}/Downloads"
          ];
        };

        screencapture = {
          location = lib.mkDefault "${homeDirectory}/Pictures/screenshots";
        };
      };
    };
  };
in {
  flake.modules.darwin.rusel.imports = [
    module
  ];
}
