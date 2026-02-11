# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > btop] fish integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.btop = {
    lib,
    config,
    ...
  }: {
    programs.fish.shellAbbrs = lib.mkIf config.programs.btop.enable {
      top = "btop";
    };
  };
}
