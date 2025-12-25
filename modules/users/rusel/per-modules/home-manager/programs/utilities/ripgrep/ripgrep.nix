{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.ripgrep = {
      enable = lib.mkForce true;
    };
  };
}
