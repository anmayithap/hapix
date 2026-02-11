# ----------------------------------------------------------------------------
# ## Rusel User Module: [Home Manager > Programs > Shells > zsh]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.rusel-zsh = {lib, ...}: {
    programs.zsh = {
      enable = lib.mkForce false;

      zsh-vi-mode = {
        enable = lib.mkForce true;
      };
    };
  };
}
