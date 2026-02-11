# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > plugins > done]
# Implementation
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.programs.fish.done-plugin;
  in {
    config = lib.mkIf cfg.enable {
      assertions = [
        {
          assertion = !(cfg.notifier.enable && !pkgs.stdenv.isDarwin);
          message = "Notifier declaring is only supported on Darwin systems.";
        }
        {
          assertion = !(cfg.notifier.enable && cfg.notifier.package == null);
          message = "Notifier is enabled, but no package is defined for it.";
        }
        {
          assertion = !(cfg.notifier.enable && pkgs.stdenv.isDarwin && cfg.notifier.package != pkgs.terminal-notifier);
          message = "For Darwin systems, you need to install the `pkgs.terminal-notifier` package.";
        }
      ];

      programs.fish.plugins = lib.mkBefore [
        {
          name = "done";
          src = cfg.package;
        }
      ];

      home.packages = lib.mkIf cfg.notifier.enable [
        cfg.notifier.package
      ];
    };
  };
}
