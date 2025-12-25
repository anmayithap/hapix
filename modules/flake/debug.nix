# =========================================================================
# == DEBUGGING: Flake evaluation and diagnostic settings.
# This module controls the debug mode for flake-parts. When enabled,
# it provides additional metadata and tools for inspecting the
# evaluation process of the entire flake.
# =========================================================================
{lib, ...}: {
  # -----------------------------------------------------------------------
  # ## Global Debug Flag
  # -----------------------------------------------------------------------
  # Enabling `debug` helps when troubleshooting complex module merges or
  # when using `flake-parts` features that provide diagnostic output.
  #
  # We use `lib.mkDefault` to set the baseline to `true`. This allows
  # specific configurations or specialized modules to override this
  # setting (e.g., in a production/CI environment) using `lib.mkForce false`.
  debug = lib.mkDefault true;
}
