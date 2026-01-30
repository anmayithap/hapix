# ----------------------------------------------------------------------------
# ## Nix Channels Preferences Module: Configures the Nix Channels preferences
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.nix-channels = {lib, ...}: {
    nix = {
      channel.enable = lib.mkDefault false;

      registry = {
        nixpkgs.flake = lib.mkForce inputs.nixpkgs;
        nixpkgs-stable.flake = lib.mkForce inputs.nixpkgs-stable;
      };

      nixPath = lib.mkBefore [
        "nixpkgs=${inputs.nixpkgs}"
        "nixpkgs-stable=${inputs.nixpkgs-stable}"
      ];
    };
  };
}
