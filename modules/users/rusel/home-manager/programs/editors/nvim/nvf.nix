{
  flake.modules.homeManager.rusel-editors = {lib, ...}: {
    programs.nvf = {
      enable = lib.mkDefault true;
      defaultEditor = lib.mkDefault true;
    };
  };
}
