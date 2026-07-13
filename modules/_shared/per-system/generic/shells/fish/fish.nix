# ----------------------------------------------------------------------------
# ## Generic Module: [Programs > Shells > fish]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.fish = {lib, ...}: {
    programs.fish = {
      enable = lib.mkDefault true;
    };
  };
}
