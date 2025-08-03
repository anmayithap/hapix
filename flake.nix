{
  description = "Anmayithap's nix configuration for both NixOS & macOS";

  inputs = {
    # ===== NixOS =====
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # ===== MacOS =====
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # ===== home-manager =====
    home-manager = {
      url = "github:nix-community/home-manager/master";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ===== secrets management =====
    agenix = {
      url = "github:ryantm/agenix/531beac616433bac6f9e2a19feb8e99a22a66baf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "nix-darwin";
        home-manager.follows = "home-manager";
      };
    };

    # ===== development tools =====
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # =====  My own repositories =====

    secrets = {
      url = "git+ssh://git@github.com/anmayithap/nix-secrets.git";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    agenix,
    pre-commit-hooks,
    secrets,
    ...
  }: let
    available-systems = ["aarch64-darwin" "x86_64-linux"];

    internal = import ./_internal {
      inherit inputs available-systems;
    };
  in
    internal.configuration-tools.mkConfigurations {
      profiles = [
        {
          system = "aarch64-darwin";
          hostname = "maple";
        }
        {
          system = "x86_64-linux";
          hostname = "nixos";
        }
      ];
    };
}
