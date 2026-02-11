# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Development > git] fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.git = {
    lib,
    pkgs,
    config,
    ...
  }: let
    predicate = config.programs.git.enable && config.programs.fish.enable && config.programs.fzf.enable;
  in {
    # ## Install forgit fish plugin.
    # See: https://github.com/wfxr/forgit
    programs.fish.plugins = lib.mkIf predicate (
      lib.mkAfter [
        {
          name = "forgit";
          src = pkgs.fetchFromGitHub {
            owner = "wfxr";
            repo = "forgit";
            rev = "26.01.0";
            sha256 = "sha256-3PjKFARsN3BE5c3/JonNj+LpKBPT1N3hc1bK6NdWDTQ=";
          };
        }
      ]
    );
  };
}
