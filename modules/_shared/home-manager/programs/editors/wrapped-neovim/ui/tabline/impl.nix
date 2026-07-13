# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Tabline]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.tabline;
  in {
    config.wrappers.neovim.specs.tabline = lib.mkIf cfg.enable {
      inherit (cfg) name pname;
      data = builtins.getAttr cfg.name (
        with pkgs.vimPlugins; {
          "mini.tabline" = mini-tabline;
        }
      );
      lazy = builtins.getAttr cfg.name {
        "mini.tabline" = false;
      };
      after = ["lze"];
    };
  };
}
