# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Development > uv]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.uv = {lib, ...}: {
    programs.uv = {
      enable = lib.mkDefault false;
    };
  };
}
