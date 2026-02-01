# ----------------------------------------------------------------------------
# ## Formatter: Set formatting for the project
# ----------------------------------------------------------------------------
{
  perSystem = {
    lib,
    config,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Treefmt Configuration
    # -----------------------------------------------------------------------
    treefmt = {
      enableDefaultExcludes = lib.mkDefault true;
      projectRootFile = lib.mkDefault config.flake-root.projectRootFile;

      flakeCheck = lib.mkDefault true;
      flakeFormatter = lib.mkDefault true;

      settings = {
        allow-missing-formatter = lib.mkDefault false;
        excludes = lib.mkDefault [
          ".direnv"
          ".vscode"
          ".git"
        ];
        fail-on-change = lib.mkDefault false;
      };

      programs = {
        # ## Nix Configuration
        alejandra = {
          enable = lib.mkDefault true;
        };
        deadnix = {
          enable = lib.mkDefault true;
        };
        nixf-diagnose = {
          enable = lib.mkDefault true;
        };
        statix = {
          enable = lib.mkDefault true;
        };

        # ## Markdown Configuration
        rumdl-check = {
          enable = lib.mkDefault true;
        };
        rumdl-format = {
          enable = lib.mkDefault true;
        };

        # ## Shell Scripting Configuration
        shellcheck = {
          enable = lib.mkDefault true;

          external-sources = lib.mkDefault true;
          extra-checks = lib.mkDefault ["all"];
        };
        shfmt = {
          enable = lib.mkDefault true;
          useEditorConfig = lib.mkDefault true;
        };

        # ## TOML Configuration
        taplo = {
          enable = lib.mkDefault true;
        };

        # ## Spell Checking Configuration
        typos = {
          enable = lib.mkDefault true;

          hidden = lib.mkDefault true;
          isolated = lib.mkDefault true;
          locale = lib.mkDefault "en-us";
          noIgnoreDot = lib.mkDefault true;
        };

        # ## YAML Configuration
        yamlfmt = {
          enable = lib.mkDefault true;
        };
        yamllint = {
          enable = lib.mkDefault true;
        };

        # ## JSON Configuration
        jsonfmt = {
          enable = lib.mkDefault true;
        };
      };
    };
  };
}
