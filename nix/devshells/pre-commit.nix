# This file defines the set of Git pre-commit hooks that will be used in this repository.
# It is imported by `nix/default.nix` to create a `check` and to configure the `devShell`.
# This function expects `pkgs` as an argument so it can access the pre-commit library.
{inputs, ...}: {
  imports = [
    inputs.git-hooks-nix.flakeModule
  ];

  perSystem = {lib, ...}: {
    pre-commit = {
      settings = {
        # The `hooks` attribute set contains all the hooks we want to enable.
        # The `pre-commit-hooks-nix` library provides these as modular options.
        hooks = {
          # -----------------------------------------------------------------------
          # ## Nix-specific Hooks
          # These hooks are essential for maintaining a high-quality Nix codebase.
          # -----------------------------------------------------------------------

          # `alejandra` is an opinionated, unconditional Nix code formatter. It ensures
          # that all Nix files in the repository have a consistent style.
          alejandra.enable = true;

          # `deadnix` scans for and reports unused variable bindings in your Nix code.
          # This helps keep the code clean and remove clutter.
          deadnix = {
            enable = true;
            args = ["-lL"];
          };

          # `statix` is a linter and static analyzer for Nix. It catches common
          # mistakes, typos in attribute names, and other potential bugs before
          # they cause issues.
          statix.enable = true;

          # `commitizen` is a tool for creating conventional commit messages.
          # It helps ensure that all commits follow a consistent format.
          commitizen.enable = true;

          # Run health checks on your flake-powered Nix projects.
          flake-checker.enable = true;

          # Incremental analysis assistant for writing in Nix.
          nil.enable = true;

          # -----------------------------------------------------------------------
          # ## General Code Hygiene Hooks
          # These are language-agnostic hooks that are good practice for any project.
          # -----------------------------------------------------------------------

          # Ensures that all text files end with a single newline character.
          end-of-file-fixer.enable = lib.mkDefault true;

          # Removes any trailing whitespace from the end of lines.
          trim-trailing-whitespace.enable = lib.mkDefault true;

          # Remove UTF-8 byte order marker.
          fix-byte-order-marker.enable = lib.mkDefault true;
        };
      };
    };
  };
}
