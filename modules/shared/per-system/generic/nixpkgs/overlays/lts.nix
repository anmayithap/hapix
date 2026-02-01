# ----------------------------------------------------------------------------
# ## LTS nixpkgs Overlay Module: Apply the LTS nixpkgs overlays
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.lts-overlay = {lib, ...}: {
    nixpkgs.overlays = lib.mkBefore [
      (
        final: _: {
          "25.11" = import inputs."nixpkgs-25.11" {
            inherit (final.stdenv.hostPlatform) system;
            inherit (final) config;
          };
        }
      )
    ];
  };
}
