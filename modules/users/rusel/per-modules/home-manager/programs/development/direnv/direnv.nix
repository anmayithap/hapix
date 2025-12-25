{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.direnv = {
      enable = lib.mkForce true;
      silent = lib.mkForce true;
    };
  };
}
