# ------------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > man]
# ------------------------------------------------------------------------------
{
  flake.modules.homeManager.man = {
    lib,
    pkgs,
    ...
  }: {
    programs.man = {
      enable = lib.mkDefault true;
      package = pkgs.man;
    };
  };
}
