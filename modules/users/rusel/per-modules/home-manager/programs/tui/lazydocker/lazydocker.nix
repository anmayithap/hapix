{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.lazydocker = {
      enable = lib.mkDefault true;
    };
  };
}
