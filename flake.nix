{
  description = "Anmayithap's unified NixOS and macOS configuration";

  # =========================================================================
  # == INPUTS: All external dependencies for this project are declared here.
  # This is the single source of truth for all external code.
  # =========================================================================
  inputs = {
    # -----------------------------------------------------------------------
    # ## Nixpkgs Sources
    # -----------------------------------------------------------------------

    # `nixpkgs` is the primary source for packages and NixOS modules.
    # We pin it to `nixos-unstable` to get the latest software versions.
    # All other inputs that require `nixpkgs` will `follow` this one to
    # ensure perfect consistency across the entire system.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # `nixpkgs-stable` provides an additional package set from the latest
    # stable NixOS release. This is useful for specific applications
    # that might be broken on `unstable` or for server environments where
    # stability is a higher priority than new features.
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11"; # Note: Update this as new versions are released.

    # -----------------------------------------------------------------------
    # ## Core System Tooling
    # -----------------------------------------------------------------------

    # `home-manager` allows for declarative management of the user environment
    # (dotfiles, user-specific packages, user services, etc.).
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `nix-darwin` provides the necessary modules to declaratively manage macOS.
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `nixos-wsl` provides the necessary modules to declaratively manage WSL.
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `nix-homebrew` manages Homebrew installations on MacOs using `nix-darwin`.
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

    # For declarative tap management.
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    # -----------------------------------------------------------------------
    # ## Development Tooling
    # -----------------------------------------------------------------------

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # -----------------------------------------------------------------------
    # ## Flake Helper Utilities
    # -----------------------------------------------------------------------

    # `flake-parts` helps structure the `outputs` of a flake, allowing us to
    # split the configuration into smaller, more manageable files.
    flake-parts.url = "github:hercules-ci/flake-parts";

    # `git-hooks-nix` provides a framework for running linters and
    # formatters as Git pre-commit hooks, ensuring code quality and consistency.
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `import-tree` some dendritic library which recursively imports nix modules from a directory.
    import-tree = {
      url = "github:vic/import-tree";
    };

    # `flake-root` module for finding your way to the project root directory
    flake-root = {
      url = "github:srid/flake-root";
    };

    # -----------------------------------------------------------------------
    # ## Secrets Management
    # -----------------------------------------------------------------------

    # `agenix` is a simple and effective utility for managing secrets
    # using age encryption.
    agenix = {
      # Pinning to a specific commit hash provides maximum reproducibility.
      url = "github:ryantm/agenix";
      # `agenix` only depends on `nixpkgs`, so that's the only follow we need.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # A private Git repository containing encrypted secrets.
    secrets = {
      url = "git+ssh://git@github.com/anmayithap/hapix-secret.git";
      # The `flake = false;` attribute is essential. It tells Nix that this
      # repository is just a collection of files and not a Nix Flake,
      # so it shouldn't try to evaluate it.
      flake = false;
    };

    # -----------------------------------------------------------------------
    # ## Miscellaneous Flakes
    # -----------------------------------------------------------------------

    # `NUR` provides a collection of Nix expressions for various purposes.
    nur = {
      url = "github:nix-community/NUR";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    betterfox = {
      url = "github:HeitorAugustoLN/betterfox-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        import-tree.follows = "import-tree";
        systems.follows = "systems";
      };
    };

    # -----------------------------------------------------------------------
    # ## Self non-flakes
    # -----------------------------------------------------------------------
    # A sequence of system names that supported by this flake.
    systems = {
      url = "path:./systems.nix";
      flake = false;
    };
  };

  # =========================================================================
  # == OUTPUTS: The results produced by this flake.
  # =========================================================================
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
    } (inputs.import-tree ./modules);
}
