# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Helpers > Deferral]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.deferral = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "deferral executor";
          name = lib.mkOption {
            type = lib.types.enum ["lze"];
            default = "lze";
            defaultText = ''"lze"'';
            description = "The name of deferral executor for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["lze"];
            default = "lze";
            defaultText = ''"lze"'';
            description = "The plugin name of deferral executor for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The deferral executor module.";
    };
  };
}
