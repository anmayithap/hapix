# ------------------------------------------------------------------------------
# ## Devshell: Reproducible environment configuration for developing this flake.
# ------------------------------------------------------------------------------
{
  perSystem = {
    config,
    pkgs,
    lib,
    ...
  }: {
    # -------------------------------------------------------------------------
    # ## Default Shell Configuration
    # -------------------------------------------------------------------------
    devshells.default = {
      name = "hapix";

      # ### Packages installed inside the environment
      packages = with pkgs; [
        # Language server
        nixd

        # System management
        nh
        nix-index
        nix-du
        nix-melt
        nix-tree

        # Formatting
        config.treefmt.build.wrapper
      ];

      # ### Predefined menu commands
      commands = [
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
