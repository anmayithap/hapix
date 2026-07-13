# ----------------------------------------------------------------------------
# ## Generic Module: [Nixpkgs > Overlays > NUR]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.nur-overlay = {lib, ...}: {
    nixpkgs.overlays = lib.mkBefore [
      inputs.nur.overlays.default
    ];
  };
}
