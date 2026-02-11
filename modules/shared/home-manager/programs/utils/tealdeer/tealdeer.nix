# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > tealdeer]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.tealdeer = {lib, ...}: {
    programs.tealdeer = {
      enable = lib.mkDefault false;
    };
  };
}
