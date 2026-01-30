# ----------------------------------------------------------------------------
# ## Nixpkgs Stable Overlay Module: Apply the stable nixpkgs
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.stable-overlay = {lib, ...}: {
    nixpkgs.overlays = lib.mkBefore [
      (
        final: _: {
          stable = import inputs.nixpkgs-stable {
            inherit (final.stdenv.hostPlatform) system;
            inherit (final) config;
          };
        }
      )
    ];
  };
}
