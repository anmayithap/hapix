{inputs, ...}: let
  nix-index-database-config = {lib, ...}: {
    imports = [
      inputs.nix-index-database.homeModules.nix-index
    ];

    programs.nix-index.enable = lib.mkDefault true;
    programs.nix-index-database.comma.enable = lib.mkDefault true;
  };
in {
  flake.modules.homeManager.nix-index = nix-index-database-config;
}
