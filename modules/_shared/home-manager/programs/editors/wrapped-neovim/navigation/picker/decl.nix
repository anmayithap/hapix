# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Navigation > Picker]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.picker = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined picker";
          name = lib.mkOption {
            type = lib.types.enum ["mini.pick"];
            default = "mini.pick";
            defaultText = ''"mini.pick"'';
            description = "The name of picker plugin for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["mini.pick"];
            default = "mini.pick";
            defaultText = ''"mini.pick"'';
            description = "The plugin name of picker plugin for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The picker module.";
    };
  };
}
