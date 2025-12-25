{
  flake.modules.homeManager.rusel = {lib, ...}: {
    services.tldr-update = {
      enable = lib.mkForce true;
    };
  };
}
