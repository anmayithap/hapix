# ----------------------------------------------------------------------------
# ## Generic Module: [Programs > Shells > zsh]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.zsh = {lib, ...}: {
    programs.zsh = {
      enable = lib.mkDefault true;
    };
  };
}
