#: ----------------------------------------------------------------------------
#: ## [FLAKE -> formatter] configure treefmt for formatting this flake
#: ----------------------------------------------------------------------------
{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  flake-file.inputs = {
    #: Source: https://github.com/numtide/treefmt-nix
    #: Documentation: https://treefmt.com/latest/
    treefmt-nix = {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      ref = "main";
    };
  };

  flake-file.formatter = pkgs: pkgs.alejandra; #: Here we define the formatter for the generated flake.nix

  perSystem = {
    lib,
    config,
    ...
  }: let
    D = lib.mkDefault;
    F = lib.mkForce;
    B = lib.mkBefore;
  in {
    treefmt = {
      projectRootFile = F ".envrc";

      settings = {
        allow-missing-formatter = D false;
        excludes = B [
          ".direnv/*"
          ".vscode/*"
          "*cache/*"
          ".pre-commit-config.yaml"
          ".git/*"
          "**/.gitignore"
          "**/.gitattributes"
          "flake.lock"
          "flake.nix"
        ];
        fail-on-change = D false;
        quiet = D false;
        walk = D "filesystem";
      };

      programs = {
        # ## Nix formatters | linters
        alejandra = {
          enable = D true;
        };
        deadnix = {
          enable = D true;
        };
        statix = {
          enable = D true;
        };
        # ## Miscellaneous formatters | linters
        typos = {
          enable = D true;
          finalPackage = D config.packages.hapix-typos;
        };
      };
    };

    #: Inject treefmt in nix devShell
    devshells.default = {
      packages = [
        #: `treefmt`
        config.treefmt.build.wrapper
      ];

      commands = [
        {
          name = "fmt";
          help = "Run declared nix formatter";
          category = "flake";
          command = "nix fmt";
        }
      ];
    };
  };
}
