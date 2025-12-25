{
  flake.modules.homeManager.rusel = {lib, ...}: {
    services.skhd.config = lib.mkAfter ''
      lcmd + lalt - t : open -a Alacritty
    '';
  };
}
