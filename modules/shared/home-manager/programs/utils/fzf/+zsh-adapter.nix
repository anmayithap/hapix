# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > fzf] zsh integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fzf = {
    lib,
    pkgs,
    config,
    ...
  }: let
    predicate = config.programs.fzf.enable && config.programs.zsh.enable;
    mkBeforeDefaultPlugins = lib.mkOrder 450;
    mkAfterDefaultCompletions = lib.mkOrder 560;
  in {
    programs.zsh = {
      plugins = lib.mkIf predicate (
        mkBeforeDefaultPlugins [
          {
            name = "fzf-tab";
            src = pkgs.zsh-fzf-tab;
            file = "share/fzf-tab/fzf-tab.plugin.zsh";
          }
        ]
      );

      initContent = lib.mkIf predicate (
        mkAfterDefaultCompletions ''
          # ## Force zsh not to show completion menu, which allows fzf-tab to capture.
          zstyle ':completion:*' menu no
        ''
      );
    };
  };
}
