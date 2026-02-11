# ----------------------------------------------------------------------------
# ## Generic Module: [Nix Index Database]
# ----------------------------------------------------------------------------
{
  flake.modules.generic.nix-index-database = {lib, ...}: {
    programs.nix-index-database = {
      comma.enable = lib.mkDefault true;
    };
  };
}
