# ----------------------------------------------------------------------------
# ## Generic Module: [Preferences > Nix Channels]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.nix-channels = {
    lib,
    pkgs,
    ...
  }: let
    nixpkgs =
      if pkgs.stdenv.isDarwin
      then inputs.nixpkgs-darwin-unstable
      else inputs.nixpkgs-unstable;
  in {
    nix = {
      channel.enable = lib.mkDefault false;

      registry = {
        nixpkgs.flake = lib.mkForce nixpkgs;
      };

      nixPath = lib.mkBefore [
        "nixpkgs=${nixpkgs}"
      ];
    };
  };
}
