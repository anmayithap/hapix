# =========================================================================
# == FORMATTING: Automated code style and linting
# This module configures `treefmt`, a multi-tool formatter that ensures
# consistency across the entire repository. It handles Nix code,
# shell scripts, and can be extended for other languages.
# =========================================================================
{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = {
    lib,
    config,
    ...
  }: {
    # -----------------------------------------------------------------------
    # ## Treefmt Configuration
    # -----------------------------------------------------------------------
    # We define the project root by looking for `flake.nix`. This tells
    # treefmt where the repository boundaries are.
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
