{
  description = "Anmayithap's unified NixOS and MacOS configuration";

  inputs = {
    # -------------------------------------------------------------------------
    # ## Nixpkgs Sources
    # -------------------------------------------------------------------------
    #: Source: https://github.com/NixOS/nixpkgs
    #: Status: https://status.nixos.org

    #: Source: https://github.com/nix-community/nixos-wsl
    #: Documentation: https://nix-community.github.io/NixOS-WSL
    nixos-wsl = {
      type = "github";
      owner = "nix-community";
      repo = "nixos-wsl";
      ref = "main";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    #: Source: https://github.com/nix-community/nix-index-database
    nix-index-database = {
      type = "github";
      owner = "nix-community";
      repo = "nix-index-database";
      ref = "main";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    #: Source: https://github.com/nix-community/nix-index-database
    nix-index-darwin-database = {
      type = "github";
      owner = "nix-community";
      repo = "nix-index-database";
      ref = "main";

      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # -------------------------------------------------------------------------
    # ## Flake Development Tooling
    # -------------------------------------------------------------------------

    # -----------------------------------------------------------------------
    # ## Secret Management
    # -----------------------------------------------------------------------

    #: Source: https://github.com/ryantm/agenix
    agenix = {
      type = "github";
      owner = "ryantm";
      repo = "agenix";
      ref = "main";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "nix-darwin";
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

    # `nix-wrapper-modules` library to create wrapped executables via the module system.
    #
    # See `index`: https://birdeehub.github.io/nix-wrapper-modules/md/intro.html

    # `neovim-nightly-overlay`
    #
    # See `index`: https://github.com/nix-community/neovim-nightly-overlay
    neovim-nightly-overlay = {
      type = "github";
      owner = "nix-community";
      repo = "neovim-nightly-overlay";
      ref = "master";

      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        flake-parts.follows = "flake-parts";
      };
    };

    # `neovim-plugin-*` is a section for neovim plugins.

    # `oil.nvim` is a buffer like explorer for neovim.
    #
    # See `index`: https://github.com/stevearc/oil.nvim
    neovim-plugin-oil = {
      type = "github";
      owner = "stevearc";
      repo = "oil.nvim";
      ref = "master";

      flake = false;
    };

    # `oil-git.nvim` is an extension for oil.nvim that adds git support.
    #
    # See `index`: https://github.com/malewicz1337/oil-git.nvim
    neovim-plugin-oil-git = {
      type = "github";
      owner = "malewicz1337";
      repo = "oil-git.nvim";
      ref = "main";

      flake = false;
    };

    # `oil-lsp-diagnostics` is a plugin for neovim that provides diagnostics for oil.nvim.
    #
    # See `index`: https://github.com/JezerM/oil-lsp-diagnostics.nvim
    neovim-plugin-oil-lsp-diagnostics = {
      type = "github";
      owner = "JezerM";
      repo = "oil-lsp-diagnostics.nvim";
      ref = "master";

      flake = false;
    };

    # `gitlab.nvim` is a plugin for make it easy to review Gitlab MRs from within Neovim.
    #
    # See `index`: https://github.com/harrisoncramer/gitlab.nvim
    neovim-plugin-gitlab = {
      type = "github";
      owner = "harrisoncramer";
      repo = "gitlab.nvim";
      ref = "v4.0.0";

      flake = false;
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

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
    } (inputs.import-tree ./modules);
}
