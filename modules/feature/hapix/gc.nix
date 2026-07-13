#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> gc] garbage collection and optimization preset
#: ----------------------------------------------------------------------------
{
  hapix.gc = {
    os = {lib, ...}: let
      D = lib.mkDefault;
    in {
      nix = {
        settings = {
          auto-optimise-store = D true;
        };

        gc = {
          automatic = D true;
        };
        optimise = {
          automatic = D true;
        };
      };
    };

    darwin = {lib, ...}: let
      A = lib.mkAfter;
    in {
      nix = let
        #: Every day at 8:30 and 20:30
        interval = [
          {
            Hour = 8;
            Minute = 30;
          }
          {
            Hour = 20;
            Minute = 30;
          }
        ];
      in {
        gc = {
          interval = A interval;
        };
        optimise = {
          interval = A interval;
        };
      };
    };
  };
}
