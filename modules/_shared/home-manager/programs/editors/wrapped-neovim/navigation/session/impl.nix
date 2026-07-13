# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Navigation > Session]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.session;
  in {
    config.wrappers.neovim.specs.session = lib.mkIf cfg.enable {
      inherit (cfg) name pname;
      data = builtins.getAttr cfg.name (
        with pkgs.vimPlugins; {
          "mini.sessions" = mini-sessions;
        }
      );
      lazy = builtins.getAttr cfg.name {
        "mini.sessions" = false;
      };
      after = ["lze"];
    };
  };
}
