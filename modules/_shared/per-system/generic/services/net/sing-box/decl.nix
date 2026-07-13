# ----------------------------------------------------------------------------
# ## Generic Module: [Services > sing-box]
# Declaration
# ----------------------------------------------------------------------------
{
  flake.modules.generic.sing-box = {lib, ...}: let
    profileOpts = {name, ...}: {
      options = {
        enable = lib.mkEnableOption "sing-box profile ${name}";

        configFile = lib.mkOption {
          type = lib.types.str;
          description = "Absolute path to the sing-box configuration file.";
        };
      };
    };
  in {
    options.services.sing-box = {
      enable = lib.mkEnableOption "sing-box";

      profiles = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule profileOpts);
        default = {};
        defaultText = ''{}'';
        description = "Multiply sing-box profiles";
      };
    };
  };
}
