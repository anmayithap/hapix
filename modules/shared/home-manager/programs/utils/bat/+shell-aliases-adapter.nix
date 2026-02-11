# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > bat] shell aliases integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.bat = {
    lib,
    config,
    ...
  }: {
    home.shellAliases = lib.mkIf config.programs.bat.enable {
      cat = "${lib.getExe config.programs.bat.package} --paging=never";
    };
  };
}
