# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Development > uv]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-uv = {lib, ...}: {
    programs.uv = {
      enable = lib.mkForce true;
    };
  };
}
