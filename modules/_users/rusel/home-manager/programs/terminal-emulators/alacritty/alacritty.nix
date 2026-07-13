# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Terminal Emulators > Alacritty]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-alacritty = {lib, ...}: {
    programs.alacritty = {
      enable = lib.mkForce false;
    };
  };
}
