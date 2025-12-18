_: let
  power = {lib, ...}: {
    power = {
      sleep = {
        computer = lib.mkDefault 20;
        display = lib.mkDefault 30;
        harddisk = lib.mkDefault 30;
      };
    };
  };
in {
  flake.modules.darwin = {inherit power;};
}
