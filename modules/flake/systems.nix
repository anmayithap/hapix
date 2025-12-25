# =========================================================================
# == SYSTEMS: Multi-platform architecture definitions
# This module defines the set of systems (CPU/OS combinations) that this
# flake supports. It determines which architectures the `perSystem`
# attributes will be generated for.
# =========================================================================
{inputs, ...}: {
  # -----------------------------------------------------------------------
  # ## Supported Architectures
  # -----------------------------------------------------------------------
  # Instead of hardcoding a list like `["x86_64-linux" "aarch64-darwin"]`,
  # we delegate the list of supported systems to an external input.
  #
  # In your `flake.nix`, `inputs.systems` points to a local file
  # (path:./systems.nix). This allows you to manage the list of
  # target platforms in a single, dedicated location without touching
  # the core logic of the flake.
  systems = import inputs.systems;
}
