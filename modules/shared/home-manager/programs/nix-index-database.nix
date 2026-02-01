# ----------------------------------------------------------------------------
# ## Home Manager: Nix Index Database section configuration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.nix-index-database = {lib, ...}: {
    programs = {
      nix-index.enable = lib.mkDefault true;
      nix-index-database.comma.enable = lib.mkDefault true;
    };
  };
}
