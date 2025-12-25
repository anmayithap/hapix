{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.direnv.nix-direnv = {
      enable = lib.mkForce true;
    };
  };
}
