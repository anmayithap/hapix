#: ----------------------------------------------------------------------------
#: ## [DEFAULTS -> darwin] default settings for all aspects
#: ----------------------------------------------------------------------------
{lib, ...}: let
  D = lib.mkDefault;
  B = lib.mkBefore;
in {
  den.default.darwin = {
    system = {
      stateVersion = D 6;

      defaults = {
        NSGlobalDomain = {
          AppleMeasurementUnits = D "Centimeters";
          AppleMetricUnits = D 1; # ## Enables metric system.
          AppleTemperatureUnit = D "Celsius";
          AppleICUForce24HourTime = D true;
        };
        menuExtraClock = {
          Show24Hour = D true;
          ShowAMPM = D false;
        };
        dock = {
          persistent-apps = B [
            {app = "/System/Applications/System Settings.app";}
          ];
        };
        iCal = {
          "first day of week" = D "Monday";
        };
      };
    };
  };
}
