{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.btop = {
      enable = lib.mkForce true;
    };
  };
}
