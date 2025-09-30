# This is a function that accepts all `inputs` from our flake.nix.
# The `{ self, nixpkgs, ... }@inputs:` syntax is a pattern that lets us
# access each input by its name, while also keeping a reference to the
# entire attribute set as `inputs`, which we'll pass down to modules.
{inputs}:
# `flake-parts` provides the `mkFlake` function, which is our main
# entrypoint for constructing the flake's `outputs`.
inputs.flake-parts.lib.mkFlake {
  inherit inputs;
} {
  # =========================================================================
  # == Global Settings
  # =========================================================================

  debug = true;

  # The list of predefined modules that will be imported by `flake-parts`.
  imports = [
    inputs.flake-parts.flakeModules.flakeModules
  ];

  # The list of systems we want to support. `flake-parts` will automatically
  # apply the `perSystem` configuration for each of these.
  systems = import inputs.systems;

  # =========================================================================
  # == Per-System Outputs
  # These attributes are generated for each architecture listed in `systems`.
  # =========================================================================
}
