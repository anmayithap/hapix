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
      # This `follows` directive is crucial. It forces home-manager to use the
      # exact same version of `nixpkgs` as our main system, which prevents
      # a wide range of common compatibility issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `nix-darwin` provides the necessary modules to declaratively manage macOS.
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      # Just like home-manager, it must be built with the same `nixpkgs`.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

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

    import-tree = {
      url = "github:vic/import-tree";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
    } (inputs.import-tree ./modules);
}
