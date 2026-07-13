# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Security > KeepassXC]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-keepassxc = {lib, ...}: {
    programs.keepassxc = {
      enable = lib.mkForce true;
    };
  };
}
