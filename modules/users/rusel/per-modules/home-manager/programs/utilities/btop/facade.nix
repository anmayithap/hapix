_: {
  flake.modules.homeManager.rusel = {
    lib,
    pkgs,
    ...
  }: {
    programs.zsh = {
      shellAliases = with pkgs; {
        top = "${lib.getExe btop}";
      };
    };
  };
}
