#: ----------------------------------------------------------------------------
#: ## [FLAKE -> DevShell] define current flake development shells
#: ----------------------------------------------------------------------------
{inputs, ...}: {
  imports = [
    inputs.devshell.flakeModule
  ];

  flake-file.inputs = {
    #: Source: https://github.com/numtide/devshell
    #: Documentation: https://numtide.github.io/devshell/
    devshell = {
      type = "github";
      owner = "numtide";
      repo = "devshell";
      ref = "main";
    };
  };

  perSystem = {
    self',
    config,
    lib,
    pkgs,
    ...
  }: {
    devshells.default = {
      name = lib.mkDefault "hapix";

      env = [
        {
          name = lib.mkDefault "NPINS_OVERRIDE_hapix";
          value = lib.mkDefault "./.";
        }
        {
          name = lib.mkDefault "FLAKE";
          value = lib.mkDefault "${inputs.hapix.outPath}";
        }
      ];

      packages = with pkgs; [
        nixd
      ];

      commands = [
        {
          package = lib.mkDefault self'.packages.nh;
          category = lib.mkDefault "flake";
        }
        {
          package = lib.mkDefault pkgs.npins;
          category = lib.mkDefault "flake";
        }
        {
          package = lib.mkDefault pkgs.nix-du;
          category = lib.mkDefault "flake";
        }
        {
          package = pkgs.nix-tree;
          category = lib.mkDefault "flake";
        }
      ];

      devshell.startup = {
        pre-commit = {
          text = lib.mkDefault config.pre-commit.installationScript;
        };
      };
    };
  };
}
