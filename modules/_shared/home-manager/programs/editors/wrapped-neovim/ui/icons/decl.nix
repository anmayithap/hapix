# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Icons]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.icons = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined icons";
          name = lib.mkOption {
            type = lib.types.enum ["mini.icons"];
            default = "mini.icons";
            defaultText = ''"mini.icons"'';
            description = "The name of icons plugin for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["mini.icons"];
            default = "mini.icons";
            defaultText = ''"mini.icons"'';
            description = "The plugin name of icons plugin for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The icons module.";
    };
  };
}
