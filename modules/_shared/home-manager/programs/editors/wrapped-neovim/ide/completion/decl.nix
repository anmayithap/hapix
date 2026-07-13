# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > IDE > Completion]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.completion = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined completion";
          name = lib.mkOption {
            type = lib.types.enum ["mini.completion"];
            default = "mini.completion";
            defaultText = ''"mini.completion"'';
            description = "The name of completion plugin for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["mini.completion"];
            default = "mini.completion";
            defaultText = ''"mini.completion"'';
            description = "The plugin name of completion plugin for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The completion module.";
    };
  };
}
