{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.bat = {
      enable = lib.mkForce true;
    };
  };
}
