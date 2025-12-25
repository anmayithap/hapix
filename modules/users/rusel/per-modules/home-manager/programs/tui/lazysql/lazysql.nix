{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.lazysql = {
      enable = lib.mkDefault true;
    };
  };
}
