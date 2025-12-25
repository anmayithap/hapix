{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.delta = {
      enable = lib.mkForce true;
    };
  };
}
