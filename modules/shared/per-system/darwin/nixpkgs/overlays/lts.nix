# ----------------------------------------------------------------------------
# ## Darwin Module: [LTS Overlay]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.darwin.lts-overlay = {lib, ...}: {
    nixpkgs.overlays = lib.mkBefore [
      (
        final: _: {
          "25.11" = import inputs."nixpkgs-25.11-darwin" {
            inherit (final.stdenv.hostPlatform) system;
            inherit (final) config;
          };
        }
      )
    ];
  };
}
