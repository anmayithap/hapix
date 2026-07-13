# ----------------------------------------------------------------------------
# ## Generic Module: [Nixpkgs > Overlays > VSCode Extensions]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.vscode-extensions-overlay = {lib, ...}: {
    nixpkgs.overlays = lib.mkBefore [
      inputs.vscode-extensions.overlays.default
    ];
  };
}
