# ----------------------------------------------------------------------------
# ## Home Manager Module: [Programs > Terminal Emulators > ghostty]
# skhd integration
# ----------------------------------------------------------------------------
{
  flake.modules.homeManager.ghostty = {
    lib,
    config,
    ...
  }: let
    predicate = config.programs.ghostty.enable && config.services.skhd.enable;
  in {
    services.skhd = {
      config = lib.mkIf predicate (
        lib.mkAfter ''
          lcmd + lalt - t : open -a Ghostty
        ''
      );
    };
  };
}
