# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > plugins > sponge]
# Implementation
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.fish.sponge-plugin;
  in {
    config = lib.mkIf cfg.enable {
      programs.fish = {
        plugins = lib.mkBefore [
          {
            name = "sponge";
            src = cfg.package;
          }
        ];

        shellInit = lib.mkAfter ''
          set sponge_successful_exit_codes 0 127
          set sponge_purge_only_on_exit true
        '';
      };
    };
  };
}
