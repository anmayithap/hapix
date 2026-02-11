# ----------------------------------------------------------------------------
# ## Generic Module: [Nixpkgs > Overlays > Unstable]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.unstable-overlay = {lib, ...}: {
    nixpkgs.overlays = lib.mkBefore [
      (
        final: _: {
          unstable = import inputs.nixpkgs-unstable {
            inherit (final.stdenv.hostPlatform) system;
            inherit (final) config;
          };
        }
      )
    ];
  };
}
