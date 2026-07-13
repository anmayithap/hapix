#: ----------------------------------------------------------------------------
#: ## [FLAKE -> testing] configure flake testing support
#: ----------------------------------------------------------------------------
{inputs, ...}: {
  imports = [
    inputs.nix-unit.modules.flake.default
  ];

  flake-file.inputs = {
    #: Source: https://github.com/nix-community/nix-unit
    #: Documentation: https://nix-community.github.io/nix-unit/introduction.html
    nix-unit = {
      type = "github";
      owner = "nix-community";
      repo = "nix-unit";
      ref = "main";

      inputs.nix-github-actions.follows = "";
    };
  };

  perSystem = {
    inputs',
    lib,
    ...
  }: {
    nix-unit = {
      allowNetwork = lib.mkDefault true;
    };

    devshells.default.commands = let
      pkg = inputs'.nix-unit.packages.default;
    in [
      {
        package = pkg;
        category = lib.mkDefault "tests";
      }
      {
        name = "nix-test";
        category = lib.mkDefault "tests";
        help = "Run all tests";
        command = "${lib.getExe pkg} --flake '.#tests' --gc-roots-dir /nix/var/nix/gcroots";
      }
    ];
  };
}
