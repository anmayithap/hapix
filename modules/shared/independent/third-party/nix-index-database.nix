_: let
  nix-index-database = {lib, ...}: {
    programs.nix-index-database.comma.enable = lib.mkDefault true;
  };
in {
  flake.modules.darwin = {inherit nix-index-database;};
  flake.modules.nixos = {inherit nix-index-database;};
}
