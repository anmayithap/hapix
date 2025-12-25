{
  flake.modules.homeManager.rusel = {lib, ...}: {
    fonts.fontconfig = {
      enable = lib.mkForce true;
    };
  };
}
