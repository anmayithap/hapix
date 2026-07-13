# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Navigation > Picker]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.picker;
  in {
    config.wrappers.neovim.specs.picker = lib.mkIf cfg.enable {
      inherit (cfg) name pname;
      data = builtins.getAttr cfg.name (
        with pkgs.vimPlugins; {
          "mini.pick" = mini-pick;
        }
      );
      lazy = builtins.getAttr cfg.name {
        "mini.pick" = false;
      };
      after = [
        "lze"
        "helpers-extra"
      ];
    };
  };
}
