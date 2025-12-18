_: let
  system = {lib, ...}: {
    system.defaults.dock = {
      autohide = lib.mkDefault true;
      expose-group-apps = lib.mkDefault true;
      orientation = lib.mkDefault "bottom";
      persistent-apps = lib.mkDefault [
        {
          app = "/System/Applications/System Settings.app";
        }
      ];
      show-recents = lib.mkDefault false;
      mineffect = lib.mkDefault "scale";

      wvous-tl-corner = lib.mkDefault 2;
      wvous-bl-corner = lib.mkDefault 13;
      wvous-br-corner = lib.mkDefault 13;
      wvous-tr-corner = lib.mkDefault 4;

      tilesize = lib.mkDefault 68;
    };
  };
in {
  flake.modules.darwin = {inherit system;};
}
