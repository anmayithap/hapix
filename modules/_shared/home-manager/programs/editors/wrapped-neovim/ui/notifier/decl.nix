# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Helpers > Notifier]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.notifier = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined notifier";
          name = lib.mkOption {
            type = lib.types.enum ["mini.notify"];
            default = "mini.notify";
            defaultText = ''"mini.notify"'';
            description = "The name of notifier plugin for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["mini.notify"];
            default = "mini.notify";
            defaultText = ''"mini.notify"'';
            description = "The plugin name of notifier plugin for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The notifier module.";
    };
  };
}
