# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > fzf] fish.fzf integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fzf = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.fzf.enable && config.programs.fish.enable;
  in {
    programs.fish.fzf-fish-plugin = lib.mkIf predicate {
      enable = lib.mkDefault true;
    };
  };
}
