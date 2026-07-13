# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Helpers > Clues]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.clues;
  in {
    config.wrappers.neovim.specs.clues = lib.mkIf cfg.enable {
      inherit (cfg) name pname;
      data = builtins.getAttr cfg.name (
        with pkgs.vimPlugins; {
          "mini.clue" = mini-clue;
        }
      );
      lazy = builtins.getAttr cfg.name {
        "mini.clue" = false;
      };
      after = ["lze"];
    };
  };
}
