{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.fastfetch = {
      enable = lib.mkForce true;
    };
  };
}
