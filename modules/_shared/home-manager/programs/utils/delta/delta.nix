# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > delta]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.delta = {
    lib,
    config,
    ...
  }: {
    programs.delta = {
      enable = lib.mkDefault false;
      enableGitIntegration = lib.mkDefault config.programs.git.enable;

      options = {
        features = lib.mkDefault "zebra-dark";
        detect-dark-light = lib.mkDefault "always";
        line-numbers = lib.mkDefault true;
        hyperlinks = lib.mkDefault true;
        side-by-side = lib.mkDefault true;
        navigate = lib.mkDefault true;
      };
    };
  };
}
