{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.mise = {
      enable = lib.mkForce true;
    };
  };
}
