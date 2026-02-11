# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > btop] shell aliases integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.btop = {
    lib,
    config,
    ...
  }: {
    home.shellAliases = lib.mkIf config.programs.btop.enable {
      top = "${lib.getExe config.programs.btop.package}";
    };
  };
}
