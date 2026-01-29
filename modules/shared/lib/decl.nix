# ----------------------------------------------------------------------------
# ## Hapix Library Declaration
# ----------------------------------------------------------------------------
{lib, ...}: let
  inherit (lib.types) submodule attrsOf unspecified;
in {
  options = {
    flake.lib = lib.mkOption {
      type = submodule {freeformType = attrsOf unspecified;};

      default = {};
      defaultText = lib.literalExpression "''{}''";

      description = ''
        `flake.lib` defines a set of special libraries that provide
        extended functionality for the internal needs of this flake.
      '';
    };
  };
}
