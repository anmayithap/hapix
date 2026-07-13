# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > IDE > Completion]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.completion;
  in {
    config.wrappers.neovim.specs.completion = lib.mkIf cfg.enable {
      inherit (cfg) name pname;
      data = builtins.getAttr cfg.name (
        with pkgs.vimPlugins; {
          "mini.completion" = mini-completion;
        }
      );
      lazy = builtins.getAttr cfg.name {
        "mini.completion" = false;
      };
      after = ["lze"];
    };
  };
}
