# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > ripgrep]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.ripgrep = {lib, ...}: {
    programs.ripgrep = {
      enable = lib.mkDefault false;
    };
  };
}
