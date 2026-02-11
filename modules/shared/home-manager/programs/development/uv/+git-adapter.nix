# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Development > uv] git integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.uv = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.uv.enable && config.programs.git.enable;
  in {
    programs.git.ignores = lib.mkIf predicate (
      lib.mkAfter [
        ".python-version"
      ]
    );
  };
}
