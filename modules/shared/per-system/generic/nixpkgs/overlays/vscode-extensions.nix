# ----------------------------------------------------------------------------
# ## VSCode Extensions Overlay Module: Apply the VSCode Extensions overlay
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.generic.vscode-extensions-overlay = {lib, ...}: {
    nixpkgs.overlays = lib.mkBefore [
      inputs.vscode-extensions.overlays.default
    ];
  };
}
