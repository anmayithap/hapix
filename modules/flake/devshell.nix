# ----------------------------------------------------------------------------
# ## Devshell: Reproducible environment configuration for developing this flake.
# ----------------------------------------------------------------------------
{
  perSystem = {
    config,
    pkgs,
    lib,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Default Shell Configuration
    # -----------------------------------------------------------------------
    devshells.default = {
      name = "hapix";

      # ### Packages installed inside the environment
      packages = with pkgs; [
        # Language server
        nixd

        # System management
        nh
        nix-index

        # Formatting
        config.treefmt.build.wrapper
      ];

      # ### Predefined menu commands
      commands = [
        {
          name = "nixh";
          help = "Nix Helper (wrapped nh) for current flake";
          category = "system";

          command = ''
            if [ -z "$1" ]; then
              ${pkgs.nh}/bin/nh --help
            else
              ${pkgs.nh}/bin/nh "$@"
            fi
          '';
        }
        {
          name = "nhsw";
          help = "Nix Helper Switch (wrapped nh switch) for current flake";
          category = "system";
          command =
            if pkgs.stdenvNoCC.isDarwin
            then ''${pkgs.nh}/bin/nh darwin switch''
            else ''${pkgs.nh}/bin/nh os switch'';
        }
        {
          name = "nhc";
          help = "Nix Helper Clean (wrapped nh clean) for current flake";
          category = "system";
          command = ''${pkgs.nh}/bin/nh clean all'';
        }
        {
          name = "nhca";
          help = "Nix Helper Clean With Keeps (wrapped nh clean) for current flake";
          category = "system";
          command = ''${pkgs.nh}/bin/nh clean all --keep 3'';
        }
        {
          name = "nhs";
          help = "Nix Helper Search (wrapped nh search) for current flake";
          category = "system";
          command = ''${pkgs.nh}/bin/nh search'';
        }
        {
          name = "fmt";
          help = "Format all files in the repository";
          category = "utils";
          command = "${config.treefmt.build.wrapper}";
        }
      ];

      # -----------------------------------------------------------------------
      # ## Shell Startup and Hooks
      # -----------------------------------------------------------------------
      devshell.startup = {
        greet.text = ''
          echo "Welcome to the Hapix DevShell"
        '';

        set-flake-environment.text = ''
          FLAKE="''$(${lib.getExe config.flake-root.package})"
          export FLAKE

          NH_FLAKE="''$(${lib.getExe config.flake-root.package})"
          export NH_FLAKE
        '';

        pre-commit.text = config.pre-commit.installationScript;
      };
    };
  };
}
