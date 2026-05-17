#: ----------------------------------------------------------------------------
#: ## [OVERLAYS -> nixpkgs -> stable] nixpkgs stable overlay
#: ----------------------------------------------------------------------------
#: Source: https://github.com/NixOS/nixpkgs
#: Status: https://status.nixos.org
{
  withSystem,
  inputs,
  ...
}: {
  flake-file.inputs = {
    nixpkgs-2511 = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-25.11";
    };
    nixpkgs-2511-darwin = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-25.11-darwin";
    };
  };

  flake.overlays.default = _: prev: (withSystem prev.stdenvNoCC.hostPlatform.system (
    {system, ...}: let
      isDarwin = prev.stdenvNoCC.isDarwin && inputs ? darwin;

      baseInput =
        if isDarwin
        then inputs.nixpkgs-2511-darwin
        else inputs.nixpkgs-2511;

      stableInstance = import baseInput {
        inherit system;
        inherit (prev) config;
      };
    in {
      pkgs-stable = stableInstance;
      pkgs-2511 = stableInstance;
    }
  ));
}
