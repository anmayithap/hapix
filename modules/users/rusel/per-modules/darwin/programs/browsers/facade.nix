{
  flake.modules.homeManager.rusel = {lib, ...}: {
    services.skhd.config = lib.mkAfter ''
      lcmd + lalt - b : open -a Google\ Chrome
    '';
  };
}
