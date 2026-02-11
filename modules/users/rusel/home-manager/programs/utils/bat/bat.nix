# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > bat]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-bat = {lib, ...}: {
    programs.bat = {
      enable = lib.mkForce true;
    };
  };
}
