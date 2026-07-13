# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Starter]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.starter = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined starter";
          name = lib.mkOption {
            type = lib.types.enum ["mini.starter"];
            default = "mini.starter";
            defaultText = ''"mini.starter"'';
            description = "The name of starter plugin for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["mini.starter"];
            default = "mini.starter";
            defaultText = ''"mini.starter"'';
            description = "The plugin name of starter plugin for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The starter module.";
    };
  };
}
