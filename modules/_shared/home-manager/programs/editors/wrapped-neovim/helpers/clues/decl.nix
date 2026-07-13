# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Helpers > Clues]
# Declaration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.clues = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined clues";
          name = lib.mkOption {
            type = lib.types.enum ["mini.clue"];
            default = "mini.clue";
            defaultText = ''"mini.clue"'';
            description = "The name of clues plugin for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["mini.clue"];
            default = "mini.clue";
            defaultText = ''"mini.clue"'';
            description = "The plugin name of clues plugin for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The clues module.";
    };
  };
}
