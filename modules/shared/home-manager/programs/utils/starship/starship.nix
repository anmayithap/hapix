# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > starship]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.starship = {lib, ...}: {
    programs.starship = {
      enable = lib.mkDefault false;
    };
  };
}
