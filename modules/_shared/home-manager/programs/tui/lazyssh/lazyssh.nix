# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > TUI > lazyssh]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.lazyssh = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.lazyssh;
  in {
    options = {
      programs.lazyssh = {
        enable = lib.mkEnableOption "lazyssh";
        package = lib.mkPackageOption pkgs "lazyssh" {};
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = [cfg.package];
    };
  };
}
