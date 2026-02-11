# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Notes > Obsidian]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-obsidian = {lib, ...}: {
    programs.obsidian = {
      enable = lib.mkForce true;
    };
  };
}
