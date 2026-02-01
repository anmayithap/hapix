# ----------------------------------------------------------------------------
# ## Darwin System Utilities Module
# ----------------------------------------------------------------------------
{inputs, ...}: {
  flake.modules.darwin.utils = {
    imports = [
      inputs.self.modules.darwin.nix-darwin
    ];
  };
}
