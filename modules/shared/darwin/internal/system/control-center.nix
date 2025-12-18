_: let
  system = {lib, ...}: {
    system.defaults.controlcenter = {
      AirDrop = lib.mkDefault false;
      BatteryShowPercentage = lib.mkDefault true;
      Bluetooth = lib.mkDefault false;
      Display = lib.mkDefault false;
      FocusModes = lib.mkDefault false;
      NowPlaying = lib.mkDefault false;
      Sound = lib.mkDefault false;
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
