# ----------------------------------------------------------------------------
# ## Nix GC Preferences Module: Configures the Nix GC preferences
# ----------------------------------------------------------------------------
{
  flake.modules.generic.nix-gc = {lib, ...}: {
    nix = {
      optimise.automatic = lib.mkDefault true;

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
