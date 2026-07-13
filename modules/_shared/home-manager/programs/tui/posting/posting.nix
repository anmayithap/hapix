# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > TUI > posting]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.posting = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.posting;
  in {
    options = {
      programs.posting = {
        enable = lib.mkEnableOption "posting";
        package = lib.mkPackageOption pkgs "posting" {};
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = [cfg.package];
    };
  };
}
