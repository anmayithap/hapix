{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.starship = {
      enable = lib.mkForce true;
    };
  };
}
