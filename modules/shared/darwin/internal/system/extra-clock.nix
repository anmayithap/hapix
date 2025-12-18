_: let
  system = {lib, ...}: {
    system.defaults.menuExtraClock = {
      FlashDateSeparators = lib.mkDefault false;
      IsAnalog = lib.mkDefault false;
      Show24Hour = lib.mkDefault true;
      ShowDayOfMonth = lib.mkDefault true;
      ShowDayOfWeek = lib.mkDefault true;
      ShowSeconds = lib.mkDefault true;
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
