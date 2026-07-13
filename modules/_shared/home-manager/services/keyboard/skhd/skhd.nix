# ----------------------------------------------------------------------------
# ## Home Manager Module: [Services > Keyboard > skhd]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.skhd = {lib, ...}: {
    services.skhd = {
      enable = lib.mkDefault true;
    };
  };
}
