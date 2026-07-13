# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > TUI > lazyjournal]
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.lazyjournal = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.lazyjournal;
  in {
    options = {
      programs.lazyjournal = {
        enable = lib.mkEnableOption "lazyjournal";
        package = lib.mkPackageOption pkgs "lazyjournal" {};
      };
    };

    config = lib.mkIf cfg.enable {
      home.packages = [cfg.package];
    };
  };
}
