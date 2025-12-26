# =========================================================================
# == SHARED LIBRARY: Selective Unfree Policy (nixpkgs-unfree)
# This module defines a type-safe and granular approach to managing
# proprietary software. Instead of a global "allowUnfree = true", it
# provides a whitelist mechanism, ensuring that only explicitly
# declared unfree packages can be installed.
# =========================================================================
{
  flake = {
    lib = {
      # -----------------------------------------------------------------------
      # ## nixpkgs-unfree Module Logic
      # -----------------------------------------------------------------------
      # This is a module function that can be injected into Darwin, NixOS,
      # or Home Manager registries.
      nixpkgs-unfree = {
        lib,
        config,
        ...
      }: {
        # ### Options Definition
        options.unfree = lib.mkOption {
          # A list of package objects that are allowed to be unfree.
          type = lib.types.listOf lib.types.package;
          default = [];
          example = "with pkgs; [ obsidian vscode ]";
          description = ''
            A whitelist of unfree packages allowed for this specific host.
            Only packages in this list will bypass the Nixpkgs unfree check.
          '';
        };

        # ### Implementation: Allow Unfree Predicate
        # We override the standard Nixpkgs behavior using a predicate.
        # For every package Nix attempts to evaluate, this function checks
        # if the package name exists in our 'unfree' whitelist.
        config.nixpkgs.config.allowUnfreePredicate = pkg: let
          # Extract the human-readable name of the package (e.g., "obsidian").
          pkgName = lib.getName pkg;

          # Extract the names of all packages currently in our whitelist.
          allowedNames = map lib.getName config.unfree;
        in
          # Logic: If the package being checked is in our list, allow it.
          lib.elem pkgName allowedNames;
      };
    };
  };
}
