# ----------------------------------------------------------------------------
# ## NUR Overlay Module: Apply the NUR overlay
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.nur-overlay = {lib, ...}: {
    nixpkgs.overlays = lib.mkBefore [
      inputs.nur.overlays.default
    ];
  };
}
