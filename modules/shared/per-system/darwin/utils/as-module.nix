# ----------------------------------------------------------------------------
# ## Darwin Module: [Utils]
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.darwin.utils = {
    imports = [
      inputs.self.modules.darwin.nix-darwin
    ];
  };
}
