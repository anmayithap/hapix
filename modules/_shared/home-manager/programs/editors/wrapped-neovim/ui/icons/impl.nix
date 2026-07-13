# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Icons]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.icons;
  in {
    config.wrappers.neovim.specs.icons = lib.mkIf cfg.enable {
      inherit (cfg) name pname;
      data = builtins.getAttr cfg.name (
        with pkgs.vimPlugins; {
          "mini.icons" = mini-icons;
        }
      );
      lazy = builtins.getAttr cfg.name {
        "mini.icons" = false;
      };
      after = ["lze"];
    };
  };
}
