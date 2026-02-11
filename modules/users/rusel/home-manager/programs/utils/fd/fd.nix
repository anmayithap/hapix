# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > fd]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-fd = {lib, ...}: {
    programs.fd = {
      enable = lib.mkForce true;
    };
  };
}
