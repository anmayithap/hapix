{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.direnv.mise = {
      enable = lib.mkForce true;
    };
  };
}
