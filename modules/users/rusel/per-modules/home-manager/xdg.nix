{
  flake.modules.homeManager.rusel = {lib, ...}: {
    xdg.enable = lib.mkForce true;

    home.preferXdgDirectories = lib.mkForce true;
  };
}
