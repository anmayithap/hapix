{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.tealdeer = {
      enable = lib.mkDefault true;
    };
  };
}
