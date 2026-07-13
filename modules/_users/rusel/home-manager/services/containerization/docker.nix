# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Services > Containerization > Docker]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-docker = {lib, ...}: {
    programs.docker-cli = {
      enable = lib.mkForce true;
    };
  };
}
