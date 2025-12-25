{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.uv = {
      enable = lib.mkForce true;
    };
  };
}
