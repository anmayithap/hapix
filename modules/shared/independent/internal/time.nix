_: let
  time = {lib, ...}: {
    time.timeZone = lib.mkDefault "Europe/Moscow";
  };
in {
  flake.modules.darwin = {inherit time;};
  flake.modules.nixos = {inherit time;};
}
