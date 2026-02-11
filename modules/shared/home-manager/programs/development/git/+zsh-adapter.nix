# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Development > git] fzf integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.git = {
    lib,
    pkgs,
    config,
    ...
  }: let
    predicate = config.programs.git.enable && config.programs.zsh.enable;
  in {
    # ## Install forgit zsh plugin.
    # See: https://github.com/wfxr/forgit
    programs.zsh.plugins = lib.mkIf predicate (
      lib.mkAfter [
        {
          name = "zsh-forgit";
          src = pkgs.zsh-forgit;
          file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
          completions = ["share/zsh/site-functions"];
        }
      ]
    );
  };
}
