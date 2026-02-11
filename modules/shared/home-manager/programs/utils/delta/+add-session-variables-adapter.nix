# ----------------------------------------------------------------------------
# ## Generic Module: [Programs > Utils > delta] session variables integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.delta = {
    lib,
    config,
    ...
  }: {
    home.sessionVariables = lib.mkIf config.programs.delta.enable {
      GIT_PAGER = lib.mkDefault "delta";
    };
  };
}
