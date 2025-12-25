{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.sketchybar = {
      enable = lib.mkForce false;
    };
  };
}
