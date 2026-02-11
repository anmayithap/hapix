# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > bat] zsh integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.bat = {
    lib,
    config,
    ...
  }: let
    mkLastConfiguration = lib.mkOrder 1500;
  in {
    programs = {
      zsh = {
        initContent = lib.mkIf config.programs.bat.enable (
          mkLastConfiguration ''
            alias -g -- -h='-h 2>&1 | ${lib.getExe config.programs.bat.package} --language=help --style=plain'
            alias -g -- --help='--help 2>&1 | ${lib.getExe config.programs.bat.package} --language=help --style=plain'
          ''
        );
      };
    };
  };
}
