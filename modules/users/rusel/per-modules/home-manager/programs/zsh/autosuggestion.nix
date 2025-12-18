_: {
  flake.modules.homeManager.rusel = {lib, ...}: {
    programs.zsh.autosuggestion = {
      enable = lib.mkForce true;
      strategy = lib.mkForce ["completion"];
    };
  };
}
