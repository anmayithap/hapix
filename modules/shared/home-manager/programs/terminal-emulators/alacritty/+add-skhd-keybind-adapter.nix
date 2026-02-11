# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Terminal Emulators > alacritty]
# skhd integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.alacritty = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.alacritty.enable && config.services.skhd.enable;
  in {
    services.skhd = {
      config = lib.mkIf predicate (
        lib.mkAfter ''
          lcmd + lalt - t : open -a Alacritty
        ''
      );
    };
  };
}
