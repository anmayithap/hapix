# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Git]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.git = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined full git";

          git = lib.mkOption {
            type = lib.types.submodule {
              options = {
                enable = lib.mkEnableOption "predefined git";
                name = lib.mkOption {
                  type = lib.types.enum ["mini.git"];
                  default = "mini.git";
                  defaultText = ''"mini.git"'';
                  description = "The name of git plugin for neovim.";
                };
                pname = lib.mkOption {
                  type = lib.types.enum ["mini.git"];
                  default = "mini.git";
                  defaultText = ''"mini.git"'';
                  description = "The plugin name of git plugin for neovim.";
                };
              };
            };
            default = {};
            defaultText = ''{}'';
            description = "The git module.";
          };

          diff = lib.mkOption {
            type = lib.types.submodule {
              options = {
                enable = lib.mkEnableOption "predefined diff";
                name = lib.mkOption {
                  type = lib.types.enum ["mini.diff"];
                  default = "mini.diff";
                  defaultText = ''"mini.diff"'';
                  description = "The name of diff plugin for neovim.";
                };
                pname = lib.mkOption {
                  type = lib.types.enum ["mini.diff"];
                  default = "mini.diff";
                  defaultText = ''"mini.diff"'';
                  description = "The plugin name of diff plugin for neovim.";
                };
              };
            };
            default = {};
            defaultText = ''{}'';
            description = "The diff module.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "the full git module.";
    };
  };
}
