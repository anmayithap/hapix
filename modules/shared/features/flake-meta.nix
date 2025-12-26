# =========================================================================
# == SHARED FEATURE: Flake Metadata Schema
# This module establishes the structural definition (schema) for global
# project metadata. It allows the flake to store and expose standardized
# information—such as source URIs—which can be consumed by other modules,
# CI/CD pipelines, or external tools.
# =========================================================================
{lib, ...}: {
  # -----------------------------------------------------------------------
  # ## Options Definition
  # -----------------------------------------------------------------------
  # We define a new option hierarchy under the 'flake' attribute.
  # In flake-parts, attributes defined here are exposed at the top-level
  # of the flake's outputs.
  options = {
    flake.meta = lib.mkOption {
      description = "Global metadata describing this specific flake configuration.";

      # ### Metadata Submodule
      # We use a submodule to provide a structured and typed set of
      # metadata fields.
      type = with lib.types;
        submodule {
          options = {
            # #### Source URI
            # The canonical location of the flake's source code.
            uri = lib.mkOption {
              description = "The primary URI (e.g., GitHub URL) of the current flake.";
              type = types.str;
              example = "github:user/repository";
            };
          };
        };
    };
  };
}
