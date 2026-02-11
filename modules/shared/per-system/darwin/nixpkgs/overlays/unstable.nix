# ----------------------------------------------------------------------------
# ## Darwin Module: [Unstable Overlay]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.darwin.unstable-overlay = {lib, ...}: {
    nixpkgs.overlays = lib.mkBefore [
      (
        final: _: {
          unstable = import inputs.nixpkgs-darwin-unstable {
            inherit (final.stdenv.hostPlatform) system;
            inherit (final) config;
          };
        }
      )
    ];
  };
}
