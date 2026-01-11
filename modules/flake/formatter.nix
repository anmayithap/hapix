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
    treefmt.projectRootFile = lib.mkDefault config.flake-root.projectRootFile;

    treefmt.programs = {
      # #### Nix Formatting
      alejandra.enable = lib.mkDefault true;
      alejandra.excludes = lib.mkDefault [".direnv"];

      # #### Nix Linting & Cleanup

      # `deadnix` scans for unused variable bindings in Nix files.
      deadnix.enable = lib.mkDefault true;

      # `statix` checks for anti-patterns and suggests idiomatic Nix code.
      statix.enable = lib.mkDefault true;

      # #### Shell Scripting

      # Ensures that any .sh files in the repo follow a consistent style.
      shfmt.enable = lib.mkDefault true;

      # #### Markdown & Docs

      # Keeps your README and documentation files clean.
      prettier.enable = lib.mkDefault true;
    };
  };
}
