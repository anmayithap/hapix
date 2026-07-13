#: ----------------------------------------------------------------------------
#: ## [FLAKE -> pre-commit] configure pre-commit hooks for this flake
#: ----------------------------------------------------------------------------
{inputs, ...}: {
  imports = [
    inputs.git-hooks-nix.flakeModule
  ];

  flake-file.inputs = {
    #: Source: https://github.com/cachix/git-hooks.nix
    git-hooks-nix = {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";
      ref = "master";
    };
  };

  perSystem = {
    lib,
    config,
    ...
  }: let
    D = lib.mkDefault;
    F = lib.mkForce;
    A = lib.mkAfter;
  in {
    pre-commit = {
      settings = {
        hooks = {
          #: Nix hooks
          treefmt = {
            enable = D (config.formatter.name == "treefmt");
            packageOverrides.treefmt = config.formatter;
          };
          #: Miscellaneous hooks
          commitizen = {
            enable = D true;
            description = D "Verify commit message";
            fail_fast = D true;
            require_serial = D true;
            verbose = D true;

            package = F config.packages.hapix-commitizen;
          };
          check-added-large-files.enable = D true;
          check-case-conflicts.enable = D true;
          check-json.enable = D true;
          check-merge-conflicts.enable = D true;
          check-symlinks.enable = D true;
          check-toml.enable = D true;
          check-vcs-permalinks.enable = D true;
          check-yaml.enable = D true;
          detect-aws-credentials.enable = D true;
          detect-private-keys.enable = D true;
          end-of-file-fixer = {
            enable = D true;
            excludes = A [
              "flake.lock" # ## For some reason, the formatter removes line breaks from `.lock` files
            ];
          };
          fix-byte-order-marker.enable = D true;
          trim-trailing-whitespace.enable = D true;
        };
      };
    };

    devshells.default.commands = [
      {
        inherit (config.pre-commit.settings) package;
        category = "git";
      }
      {
        package = config.packages.hapix-commitizen;
        category = "git";
      }
    ];
  };
}
