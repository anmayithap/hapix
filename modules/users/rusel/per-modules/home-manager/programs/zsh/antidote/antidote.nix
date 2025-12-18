_: {
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh.antidote = {
      enable = lib.mkForce true;
      useFriendlyNames = lib.mkForce true;
    };
  };
}
