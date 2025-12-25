{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.lazygit = {
      enable = lib.mkDefault true;
    };
  };
}
