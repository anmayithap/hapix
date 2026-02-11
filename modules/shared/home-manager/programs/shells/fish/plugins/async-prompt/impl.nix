# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > plugins > async-prompt]
# Implementation
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.fish.async-prompt-plugin;
  in {
    config = lib.mkIf cfg.enable {
      programs.fish.plugins = lib.mkBefore [
        {
          name = "async-prompt";
          src = cfg.package;
        }
      ];
    };
  };
}
