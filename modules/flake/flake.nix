# =========================================================================
# == FLAKE METADATA: Global identity and project information
# This module defines top-level metadata for the entire flake.
# This information can be used by CI/CD pipelines, documentation
# generators, or other flakes that consume this project.
# =========================================================================
{lib, ...}: {
  config.flake = {
    # -----------------------------------------------------------------------
    # ## Project Metadata
    # -----------------------------------------------------------------------
    # The `meta` attribute set is a convention for storing descriptive
    # information about the flake.
    meta = {
      # ### Source URI
      # The canonical location of this flake's source code.
      uri = lib.mkDefault "github:anmayithap/hapix";
    };
  };
}
