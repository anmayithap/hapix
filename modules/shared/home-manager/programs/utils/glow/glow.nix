# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Utils > glow]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.glow = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.glow;
  in {
    options = {
      programs.glow = {
        enable = lib.mkEnableOption "glow. Renderer markdown on the CLI.";
        package = lib.mkPackageOption pkgs "glow" {};
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = [cfg.package];
    };
  };
}
