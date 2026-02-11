# ----------------------------------------------------------------------------
# ## Generic Module: [Preferences > Nix GC]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.nix-gc = {lib, ...}: {
    nix = {
      optimise = {
        automatic = lib.mkDefault true;

        interval = lib.mkBefore [
          {
            Hour = 8;
            Minute = 30;
          }
        ];
      };

      gc = {
        automatic = lib.mkDefault true;

        interval = lib.mkBefore [
          {
            Hour = 8;
            Minute = 30;
          }
        ];
      };
    };
  };
}
