# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Colorscheme]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.colorscheme = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined colorscheme";
          name = lib.mkOption {
            type = lib.types.enum ["ayu-dark"];
            default = "ayu-dark";
            defaultText = ''"ayu-dark"'';
            description = "The name of colorscheme for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["neovim-ayu"];
            default = "neovim-ayu";
            defaultText = ''"neovim-ayu"'';
            description = "The plugin name of colorscheme for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The colorscheme module.";
    };
  };
}
