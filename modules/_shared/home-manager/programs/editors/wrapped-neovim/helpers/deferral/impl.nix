# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim > Helpers > Deferral]
# Implementation
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim.settings.deferral;
  in {
    config.wrappers.neovim.specs.deferral = lib.mkIf cfg.enable {
      inherit (cfg) name pname;
      data = with pkgs.vimPlugins; [
        (
          builtins.getAttr cfg.name {
            "lze" = lze;
          }
        )
        mini-misc # Deferral helper module
      ];
      lazy = lib.mkDefault false;
    };
  };
}
