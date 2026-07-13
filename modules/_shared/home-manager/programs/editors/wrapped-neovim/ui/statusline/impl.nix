# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Statusline]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.statusline;
  in {
    config.wrappers.neovim.specs.statusline = lib.mkIf cfg.enable {
      inherit (cfg) name pname;
      data = builtins.getAttr cfg.name (
        with pkgs.vimPlugins; {
          "mini.statusline" = mini-statusline;
        }
      );
      lazy = builtins.getAttr cfg.name {
        "mini.statusline" = false;
      };
      after = ["lze"];
    };
  };
}
