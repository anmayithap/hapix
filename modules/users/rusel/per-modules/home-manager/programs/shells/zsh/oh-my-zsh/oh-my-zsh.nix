{
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh.oh-my-zsh = {
      enable = lib.mkDefault true;
    };
  };
}
