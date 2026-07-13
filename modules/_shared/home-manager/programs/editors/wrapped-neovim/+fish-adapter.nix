# -----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Editors > wrapped-neovim]
# Fish Integration
# -----------------------------------------------------------------------------
{
  flake.modules.homeManager.wrapped-neovim = {
    lib,
    config,
    ...
  }: let
    cfg = config.wrappers.neovim;
    predicate = config.programs.fish.enable && cfg.enable;
  in {
    programs.fish.shellAbbrs = lib.mkIf predicate {
      vim = cfg.binName;
      vi = cfg.binName;
      vimdiff = "${cfg.binName} -d";
    };
  };
}
