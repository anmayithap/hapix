_: {
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh = {
      enableCompletion = lib.mkForce true;
    };
  };
}
