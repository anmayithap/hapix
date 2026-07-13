#: ----------------------------------------------------------------------------
#: ## [FLAKE -> parts] configuration `flake-parts` module
#: ----------------------------------------------------------------------------
#: Configuration of the `flake-parts` module and everything connected with it.
#: This module the `flake` namespace configures only flake-parts and its dependencies,
#: which cannot be imagined without it and allocated to some other module.
{
  self,
  inputs,
  ...
}: {
  imports = [
    (inputs.files + "/flake-module.nix")
    inputs.nix-wrapper-modules.flakeModules.default
  ];

  flake-file.inputs = {
    #: Source: https://github.com/hercules-ci/flake-parts
    #: Documentation: https://flake.parts
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      ref = "main";

      inputs.nixpkgs-lib.follows = "";
    };
    #: Source: https://github.com/mightyiam/files
    #: Documentation: https://flake.parts/options/files.html
    files = {
      type = "github";
      owner = "mightyiam";
      repo = "files";
      ref = "master";

      #: Disable all transitive dependencies because
      #: these are used for development purposes only.
      inputs = {
        git-hooks.follows = "";
        import-tree.follows = "";
        make-shell.follows = "";
        nixpkgs.follows = "";
        systems.follows = "";
        treefmt-nix.follows = "";
      };
    };
    #: Source: https://github.com/birdeehub/nix-wrapper-modules
    #: Documentation: https://birdeehub.github.io/nix-wrapper-modules
    nix-wrapper-modules = {
      type = "github";
      owner = "birdeehub";
      repo = "nix-wrapper-modules";
      ref = "main";
    };
  };

  perSystem = {config, ...}: {
    #: We declare the root of the working configuration directory
    files.gitToplevel = self;
    #: Exporting the file generation script
    packages.generate-files = config.files.writer.drv;

    devshells.default.commands = [
      {
        name = "generate-files";
        help = "Generate flake files";
        category = "flake";
        command = "nix run .#generate-files --offline";
      }
    ];
  };
}
