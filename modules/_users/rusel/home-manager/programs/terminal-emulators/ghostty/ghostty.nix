# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Terminal Emulators > Ghostty]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-ghostty = {lib, ...}: {
    programs.ghostty = {
      enable = lib.mkForce true;
    };
  };
}
