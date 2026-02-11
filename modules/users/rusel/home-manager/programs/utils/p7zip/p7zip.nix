# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Utils > p7zip]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-p7zip = {lib, ...}: {
    programs.p7zip = {
      enable = lib.mkDefault true;
    };
  };
}
