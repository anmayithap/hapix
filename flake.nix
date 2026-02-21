{
  description = "Anmayithap's unified NixOS and macOS configuration";

  # -----------------------------------------------------------------------
  # ## Inputs: All external dependencies for this project are declared here.
  # -----------------------------------------------------------------------
  inputs = {
    # -----------------------------------------------------------------------
    # ## Nixpkgs Sources
    # -----------------------------------------------------------------------

    # ## `nixpkgs` is the main source of packages and modules for the nix ecosystem.
    # This input is used as the main and at the same time stable package source.
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-25.11";
    };

    # ## `nixpkgs-25.11` this is stable channel 25.11
    "nixpkgs-25.11" = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-25.11";
    };

    # ## `nixpkgs-unstable` is a unstable branch of the nix ecosystem package sources.
    # This can be used to get unstable versions of packages if the stable branch is not suitable.
    nixpkgs-unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };

    # ## `nixpkgs-darwin` is a nix ecosystem package sources for Darwin.
    # This is a stable branch of the nix ecosystem package sources.
    nixpkgs-darwin = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-25.11-darwin";
    };

    # ## `nixpkgs-25.11-darwin` this is stable channel 25.11
    "nixpkgs-25.11-darwin" = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-25.11-darwin";
    };

    # ## `nixpkgs-darwin-unstable` is a nix ecosystem package sources for Darwin.
    # This can be used to get unstable versions of packages if the stable branch is not suitable.
    nixpkgs-darwin-unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
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

      inputs.nixpkgs.follows = "nixpkgs-darwin-unstable";
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

      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # `nixos-wsl` provides the necessary modules to declaratively manage WSL.
    #
    # See `index`: https://nix-community.github.io/NixOS-WSL
    nixos-wsl = {
      type = "github";
      owner = "nix-community";
      repo = "nixos-wsl";
      ref = "main";

      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.flake-compat.follows = "flake-compat";
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

      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.flake-compat.follows = "flake-compat";
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

    # `flake-compat` is a compatibility layer for flakes.
    #
    # See `index`: https://github.com/NixOS/flake-compat
    flake-compat = {
      type = "github";
      owner = "NixOS";
      repo = "flake-compat";
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
        nixpkgs.follows = "nixpkgs-unstable";
        darwin.follows = "nix-darwin";
        home-manager.follows = "home-manager";
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
        nixpkgs.follows = "nixpkgs-unstable";
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
        nixpkgs.follows = "nixpkgs-unstable";
        flake-parts.follows = "flake-parts";
        import-tree.follows = "import-tree";
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
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };

    # `nvf` A Neovim configuration framework.
    #
    # See `index`: https://nvf.notashelf.dev/
    nvf = {
      type = "github";
      owner = "notashelf";
      repo = "nvf";
      ref = "main";

      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
        systems.follows = "systems";
      };
    };

    # `nix-wrapper-modules` library to create wrapped executables via the module system.
    #
    # See: `index`: https://birdeehub.github.io/nix-wrapper-modules/md/intro.html
    wrapper = {
      type = "github";
      owner = "birdeehub";
      repo = "nix-wrapper-modules";
      ref = "main";

      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
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
