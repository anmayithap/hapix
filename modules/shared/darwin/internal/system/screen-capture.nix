_: let
  system = {lib, ...}: {
    system.defaults.screencapture = {
      include-date = lib.mkDefault true;
      target = lib.mkDefault "file";
      type = lib.mkDefault "jpg";
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
