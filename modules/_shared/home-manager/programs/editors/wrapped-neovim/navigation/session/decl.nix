# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Navigation > Session]
# Declaration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {lib, ...}: {
    options.wrappers.neovim.settings.session = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "predefined session";
          name = lib.mkOption {
            type = lib.types.enum ["mini.sessions"];
            default = "mini.sessions";
            defaultText = ''"mini.sessions"'';
            description = "The name of session plugin for neovim.";
          };
          pname = lib.mkOption {
            type = lib.types.enum ["mini.sessions"];
            default = "mini.sessions";
            defaultText = ''"mini.sessions"'';
            description = "The plugin name of session plugin for neovim.";
          };
        };
      };
      default = {};
      defaultText = ''{}'';
      description = "The session module.";
    };
  };
}
