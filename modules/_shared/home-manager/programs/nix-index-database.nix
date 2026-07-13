# ----------------------------------------------------------------------------
# ## Home Manager: [Programs > nix-index-database]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.nix-index-database = {lib, ...}: {
    programs = {
      nix-index.enable = lib.mkDefault true;
      nix-index-database.comma.enable = lib.mkDefault true;
    };
  };
}
