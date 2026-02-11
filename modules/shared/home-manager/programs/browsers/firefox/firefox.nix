# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Browser > Firefox]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.firefox = {lib, ...}: {
    programs.firefox = {
      enable = lib.mkDefault false;
    };
  };
}
