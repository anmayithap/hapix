_: let
  home-manager = {lib, ...}: {
    home-manager = {
      useGlobalPkgs = lib.mkDefault false;
      useUserPackages = lib.mkDefault true;
      backupFileExtension = lib.mkDefault "home-manager.backup";
      verbose = lib.mkDefault true;
    };
  };
in {
  flake.modules.homeManager = {inherit home-manager;};
  flake.modules.darwin = {inherit home-manager;};
  flake.modules.nixos = {inherit home-manager;};
}
