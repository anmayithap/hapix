# ----------------------------------------------------------------------------
# ## Nix Trust Preferences Module: Configures the Nix Trust preferences
# ----------------------------------------------------------------------------
{
  flake.modules.generic.nix-trust = {lib, ...}: {
    nix.settings = {
      allowed-users = lib.mkBefore [
        "root"
      ];
      trusted-users = lib.mkBefore [
        "root"
      ];
      substituters = lib.mkBefore [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = lib.mkBefore [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      builders-use-substitutes = lib.mkDefault true;
    };
  };
}
