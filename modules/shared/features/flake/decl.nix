# ----------------------------------------------------------------------------
# ## Features: Flake Metadata Declaration
# ----------------------------------------------------------------------------
{lib, ...}: {
  options = {
    flake.meta = lib.mkOption {
      description = "flake metadata module";

      type = with lib.types;
        submodule {
          options = {
            uri = lib.mkOption {
              description = "The primary URI (e.g., GitHub URL) of the current flake.";
              type = types.str;
              example = "github:user/repository";
              default = "";
            };
          };
        };
    };
  };
}
