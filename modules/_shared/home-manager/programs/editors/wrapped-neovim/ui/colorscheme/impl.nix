# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > UI > Colorscheme]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.colorscheme;
  in {
    config.wrappers.neovim.specs.colorscheme = lib.mkIf cfg.enable {
      inherit (cfg) name pname;
      data = builtins.getAttr cfg.name {
        ayu-dark = null; # ## I'll choose the color palette myself
      };
      lazy = lib.mkDefault true;
      after = ["lze"];
    };
  };
}
