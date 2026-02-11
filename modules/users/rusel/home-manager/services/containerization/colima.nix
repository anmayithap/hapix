# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Services > Containerization > Colima]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-colima = {lib, ...}: {
    services.colima = {
      enable = lib.mkForce true;
    };
  };
}
