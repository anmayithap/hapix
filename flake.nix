{
  description = "Anmayithap's unified NixOS and macOS configuration";

  # -----------------------------------------------------------------------
  # ## Inputs: All external dependencies for this project are declared here.
  # -----------------------------------------------------------------------
  inputs = {
    # -----------------------------------------------------------------------
    # ## Nixpkgs Sources
    # -----------------------------------------------------------------------

    # `nixpkgs` is the main source of packages and modules for the nix ecosystem.
    # This input is used as the main and at the same time unstable
    # package source.
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "master";
    };

    # `nixpkgs-stable` is already a stable branch of the nix ecosystem package sources.
    # This can be used to get stable versions of packages if the unstable branch is not suitable.
    #
    # Note: It is necessary to update the nixpkgs-stable version with new stable versions of nixpkgs.
    nixpkgs-stable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "25.11";
    };

    # -----------------------------------------------------------------------
    # ## System management tools
    # -----------------------------------------------------------------------
    # This section declares the inputs that are used for system configuration,
    # in addition to nixpkgs, which actually allows you to customize `linux` exclusively
    # systems, we can also introduce other inputs like `home-manager`, `nix-darwin`, etc.

    # `nix-darwin` provides macOS-specific system settings.
    #
    # See `index`: https://nix-darwin.github.io/nix-darwin/manual/index.html
    nix-darwin = {
      type = "github";
      owner = "LnL7";
      repo = "nix-darwin";
      ref = "master";

      # In fact, we force the unstable branch of nixpkgs to use `nix-darwin`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `home-manager` allows you to configure the user environment directly.
    # This is de facto support for the declarative $HOME configuration.
    #
    # See `index`: https://nix-community.github.io/home-manager/index.xhtml
    # See `options`: https://nix-community.github.io/home-manager/options.xhtml
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";

      # In fact, we force the unstable branch of nixpkgs to use `home-manager`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `nixos-wsl` provides the necessary modules to declaratively manage WSL.
    #
    # See `index`: https://nix-community.github.io/NixOS-WSL
    nixos-wsl = {
      type = "github";
      owner = "nix-community";
      repo = "nixos-wsl";
      ref = "main";

      # In fact, we force the unstable branch of nixpkgs to use `nixos-wsl`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `nix-homebrew` dependency for `nix-darwin`.
    # Allows you to install macOS packages directly from the Homebrew registry.
    nix-homebrew = {
      type = "github";
      owner = "zhaofengli";
      repo = "nix-homebrew";
      ref = "main";
    };

    # `homebrew-core` dependency for `nix-homebrew`.
    # Required for declarative control of homebrew taps.
    #
    # Note: this is not flake! This default formulae for the missing package manager for macos (or linux).
    homebrew-core = {
      type = "github";
      owner = "homebrew";
      repo = "homebrew-core";
      ref = "main";

      flake = false;
    };

    # `homebrew-cask` dependency for `nix-homebrew`.
    # Required for declarative control of homebrew taps.
    #
    # Note: this is not flake! This a CLI workflow for the administration of macOS applications distributed as binaries.
    homebrew-cask = {
      type = "github";
      owner = "homebrew";
      repo = "homebrew-cask";
      ref = "main";

      flake = false;
    };

    # -----------------------------------------------------------------------
    # ## Development Tooling
    # -----------------------------------------------------------------------
    # This section allows you to integrate various development tools
    # the current flake, or integrating their `pkgs` into the finished system.

    # `devshell` is a tool for managing shell environments.
    # It allows you to define a set of packages and their versions,
    # and then install them into a shell environment.
    #
    # See `index`: https://numtide.github.io/devshell/
    devshell = {
      type = "github";
      owner = "numtide";
      repo = "devshell";
      ref = "main";

      # In fact, we force the unstable branch of nixpkgs to use `devshell`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `nix-index-database` это еженедельно обновляемая база данных nix-index.
    #
    # See `nix-index-database`: https://github.com/nix-community/nix-index-database
    # See `nix-index`: https://github.com/nix-community/nix-index
    nix-index-database = {
      type = "github";
      owner = "nix-community";
      repo = "nix-index-database";
      ref = "main";

      # In fact, we force the unstable branch of nixpkgs to use `nix-index-database`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `treefmt-nix` allows you to use `treefmt` and configure it declaratively.
    #
    # See `treefmt-nix`: https://github.com/numtide/treefmt-nix
    # See `index`: https://treefmt.com/latest/
    treefmt-nix = {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      ref = "main";

      # In fact, we force the unstable branch of nixpkgs to use `treefmt-nix`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `flake-parts` is a framework for structuring flake outputs,
    # allowing us to split the configuration into more manageable files.
    #
    # See `index`: https://flake.parts/
    # See `options`: https://flake.parts/options/flake-parts.html
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      ref = "main";
    };

    # `git-hooks-nix` provides a declarative wrapper around `pre-commit`,
    # allowing you to integrate checks and code formatting directly
    # via `git hooks`.
    #
    # See `index`: https://github.com/cachix/git-hooks.nix
    git-hooks-nix = {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";
      ref = "master";

      # In fact, we force the unstable branch of nixpkgs to use `git-hooks-nix`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # `import-tree` is an implementation of the nix dendritic library.
    # It allows you to recursively import nix files from a directory
    # like modules.
    #
    # See `index`: https://github.com/vic/import-tree
    import-tree = {
      type = "github";
      owner = "vic";
      repo = "import-tree";
      ref = "main";
    };

    # `flake-root` allows you to integrate a root directory finder module into your project.
    #
    # See `index`: https://github.com/srid/flake-root
    flake-root = {
      type = "github";
      owner = "srid";
      repo = "flake-root";
      ref = "master";
    };

    # -----------------------------------------------------------------------
    # ## Secrets Management
    # -----------------------------------------------------------------------

    # `agenix` provides the ability to manipulate secret files simply and efficiently.
    #
    # See `index`: https://ryantm.github.io/agenix/
    agenix = {
      type = "github";
      owner = "ryantm";
      repo = "agenix";
      ref = "main";

      inputs = {
        # In fact, we force the unstable branch of `nixpkgs` to use `agenix`
        nixpkgs.follows = "nixpkgs";
        # In fact, we force the our `nix-darwin` input to use `agenix`
        darwin.follows = "nix-darwin";
        # In fact, we force the our `home-manager` input to use `agenix`
        home-manager.follows = "home-manager";
        # In fact, we force the our `systems` input to use `agenix`
        systems.follows = "systems";
      };
    };

    # -----------------------------------------------------------------------
    # ## Flakes providing miscellaneous Nix expressions
    # -----------------------------------------------------------------------

    # `nur` (Nix User Repository) provides a collection of Nix expressions.
    # Some users in OSS offer their own options and settings for configurations.
    #
    # See `index`: https://nur.nix-community.org/
    nur = {
      type = "github";
      owner = "nix-community";
      repo = "NUR";
      ref = "main";

      inputs = {
        # In fact, we force the unstable branch of `nixpkgs` to use `nur`
        nixpkgs.follows = "nixpkgs";
        # In fact, we force the our `flake-parts` input to use `nur`
        flake-parts.follows = "flake-parts";
      };
    };

    # `betterfox` is a declarative option for using the `betterfox` repository.
    #
    # See `index`: https://github.com/HeitorAugustoLN/betterfox-nix
    # See `betterfox`: https://github.com/yokoffing/Betterfox
    betterfox = {
      type = "github";
      owner = "HeitorAugustoLN";
      repo = "betterfox-nix";
      ref = "main";

      inputs = {
        # In fact, we force the unstable branch of `nixpkgs` to use `betterfox`
        nixpkgs.follows = "nixpkgs";
        # In fact, we force the our `flake-parts` input to use `betterfox`
        flake-parts.follows = "flake-parts";
        # In fact, we force the our `import-tree` input to use `betterfox`
        import-tree.follows = "import-tree";
        # In fact, we force the our `systems` input to use `betterfox`
        systems.follows = "systems";
      };
    };

    # `vscode-extensions` is a collection of VSCode extensions.
    #
    # See `index`: https://github.com/nix-community/nix-vscode-extensions
    vscode-extensions = {
      type = "github";
      owner = "nix-community";
      repo = "nix-vscode-extensions";
      ref = "master";

      inputs = {
        # In fact, we force the unstable branch of `nixpkgs` to use `vscode-extensions`
        nixpkgs.follows = "nixpkgs";
      };
    };

    # -----------------------------------------------------------------------
    # ## Self non-flakes
    # -----------------------------------------------------------------------

    # `secrets` is a private Git repository containing encrypted secrets.
    #
    # Note: This is not a flake! This is a collection of secrets files.
    secrets = {
      url = "git+ssh://git@github.com/anmayithap/hapix-secret.git";

      flake = false;
    };

    # `systems` is a sequence of system names that supported by this flake.
    #
    # Note: This is not a flake! This is a file.
    systems = {
      type = "path";
      path = "./systems.nix";

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
