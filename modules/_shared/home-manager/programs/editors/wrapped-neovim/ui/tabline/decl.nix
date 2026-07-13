# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Tabline]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.tabline = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined tabline";
          name = lib.mkOption {
            type = lib.types.enum ["mini.tabline"];
            default = "mini.tabline";
            defaultText = ''"mini.tabline"'';
            description = "The name of tabline plugin for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["mini.tabline"];
            default = "mini.tabline";
            defaultText = ''"mini.tabline"'';
            description = "The plugin name of tabline plugin for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The tabline module.";
    };
  };
}
