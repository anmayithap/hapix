# ----------------------------------------------------------------------------
# ## Flake Module: Flake evaluation debug configuration.
# All debugging settings for this flake are defined here.
# ----------------------------------------------------------------------------
{lib, ...}: {
  # -----------------------------------------------------------------------
  # ## Global Debug Flag
  # -----------------------------------------------------------------------
  # This is a global debug flag for all flake. Integrated via flake-parts.
  debug = lib.mkDefault true;
}
