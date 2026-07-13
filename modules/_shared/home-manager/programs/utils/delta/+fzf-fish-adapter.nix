# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > delta] fzf.fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.delta = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.fish.fzf-fish-plugin.enable && config.programs.delta.enable;
  in {
    programs.fish.shellInit = lib.mkIf predicate (
      lib.mkAfter ''
        set fzf_diff_highlighter "delta --paging=never"
      ''
    );
  };
}
