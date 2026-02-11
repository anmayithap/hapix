# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > eza] fzf.fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.eza = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.fish.fzf-fish-plugin.enable && config.programs.eza.enable;
  in {
    programs.fish.shellInit = lib.mkIf predicate (
      lib.mkAfter ''
        set fzf_preview_dir_cmd eza --all --color=always
      ''
    );
  };
}
