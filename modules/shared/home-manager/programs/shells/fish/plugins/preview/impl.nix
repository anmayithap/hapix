# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Shells > Fish > plugins > preview.fish]
# Implementation
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.fish = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.fish.preview-fish-plugin;
    fzfFishCfg = config.programs.fish.fzf-fish-plugin;
  in {
    config = lib.mkIf cfg.enable {
      assertions = [
        {
          assertion = config.programs.timg.enable && config.programs.glow.enable && config.programs.p7zip.enable;
          message = "Programs [timg, glow, p7zip] required for preview.fish plugin.";
        }
      ];

      programs.fish.plugins = lib.mkBefore [
        {
          name = "preview";
          src = cfg.package;
        }
      ];

      programs.fish.shellInit = lib.mkIf fzfFishCfg.enable (
        lib.mkBefore ''
          set fzf_preview_file_cmd preview
        ''
      );
    };
  };
}
