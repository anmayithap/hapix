#: ----------------------------------------------------------------------------
#: [FEATURE -> hapix -> nix-index] nix-index preset
#: ----------------------------------------------------------------------------
{inputs, ...}: {
  flake-file.inputs = {
    nix-index-database = {
      type = "github";
      owner = "nix-community";
      repo = "nix-index-database";
      ref = "main";
    };
  };

  hapix.nix-index = {
    darwin = {
      imports = [
        inputs.nix-index-database.darwinModules.default
      ];
    };
    nixos = {
      imports = [
        inputs.nix-index-database.nixosModules.default
      ];
    };
    homeManager = {lib, ...}: let
      D = lib.mkDefault;
    in {
      imports = [
        inputs.nix-index-database.homeModules.default
      ];

      programs.nix-index-database = {
        comma.enable = D true;
      };
    };

    os = {lib, ...}: let
      D = lib.mkDefault;
    in {
      programs.nix-index-database = {
        comma.enable = D true;
      };
    };
  };
}
