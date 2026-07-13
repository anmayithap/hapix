# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Statusline]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.statusline = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined statusline";
          name = lib.mkOption {
            type = lib.types.enum ["mini.statusline"];
            default = "mini.statusline";
            defaultText = ''"mini.statusline"'';
            description = "The name of statusline plugin for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["mini.statusline"];
            default = "mini.statusline";
            defaultText = ''"mini.statusline"'';
            description = "The plugin name of statusline plugin for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The statusline module.";
    };
  };
}
