# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim]
# Session Variables Integration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim;
  in {
    home.sessionVariables = lib.mkIf cfg.enable {
      EDITOR = lib.mkDefault cfg.binName;
      VISUAL = lib.mkDefault cfg.binName;
    };
  };
}
